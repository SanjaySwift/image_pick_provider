import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {

  Position? _currentPosition;
  String? _currentAddress;
  String? _placeName;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isPermissionDenied = false;

  Position? get getCurrentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  String? get placeName => _placeName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isPermissionDenied => _isPermissionDenied;


  void updatePlaceName({required String placeName}) {
    if (placeName != _placeName) {  // Only update if different
      _placeName = placeName;
      notifyListeners();
    }
  }

  void updateCurrentAddress({required String currentAddress}){
    if (currentAddress != _currentAddress) {  // Only update if different
      _currentAddress = currentAddress;
      notifyListeners();
    }
  }

  Future<void> updatePosition({required double lat, required double lng}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentPosition = Position(
        latitude: lat,
        longitude: lng,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
     // await _getAddressFromLatLng(_currentPosition!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update position: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  LocationProvider() {
    getCurrentLocation();
  }



  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _errorMessage = null;
    _isPermissionDenied = false;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage = 'Location services are disabled. Please enable them.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Request permissions
      bool permissionGranted = await _requestLocationPermission();
      if (!permissionGranted) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      await _getAddressFromLatLng(_currentPosition!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to get location: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      bool? shouldRequestAgain = await _showPermissionDialog();
      if (shouldRequestAgain != true) {
        _errorMessage = 'Location permissions are denied.';
        _isPermissionDenied = true;
        return false;
      }
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      _errorMessage = 'Location permissions are permanently denied. Please enable them in settings.';
      _isPermissionDenied = true;
      return false;
    }
    bool isGranted = permission == LocationPermission.always || permission == LocationPermission.whileInUse;
    if (!isGranted) {
      _errorMessage = 'Location permissions are not granted.';
      _isPermissionDenied = true;
    }
    return isGranted;
  }

  Future<bool?> _showPermissionDialog() async {
    try {
      return await showDialog<bool>(
        context: navigatorKey.currentState!.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Permission Required'),
            content: const Text(
                'This app needs location access to function properly. Please allow location permission.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User explicitly denied
                },
                child: const Text('Deny'),
              ),
              TextButton(
                onPressed: () async {
                  // Only request permission when Allow is clicked
                  LocationPermission permission = await Geolocator.requestPermission();
                  bool isGranted = permission == LocationPermission.always ||
                      permission == LocationPermission.whileInUse;

                  if (isGranted) {
                    Navigator.of(context).pop(true); // Close dialog and return true
                  } else {
                    // Show option to open settings if permission not granted
                    bool? openSettings = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Permission Required'),
                        content: const Text('Please grant location permission in app settings.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Open Settings'),
                          ),
                        ],
                      ),
                    );

                    if (openSettings == true) {
                      await Geolocator.openAppSettings();
                    }
                    // Don't close the main permission dialog
                  }
                },
                child: const Text('Allow'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('Error showing permission dialog: $e');
      _errorMessage = 'Unable to show permission dialog.';
      _isPermissionDenied = true;
      return false;
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placeMarks.isEmpty) {
        _errorMessage = 'No address found for the given coordinates.';
        return;
      }
      Placemark place = placeMarks[0];
      _currentAddress = [
        place.thoroughfare,
        place.subLocality,
        place.locality,
        place.postalCode,
        place.country,
      ].where((element) => element != null && element.isNotEmpty).join(', ');
      _placeName = place.name ?? 'Unknown';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Unable to retrieve address.';
    }
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();