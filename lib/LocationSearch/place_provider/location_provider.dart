import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;
  String? _placeName;
  bool _isLoading = false;
  bool _isCurrentLocationLoading = true;
  String? _errorMessage;
  bool _isLocationServiceDisabled = false;
  bool _isPermissionDenied = false;

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  String? get placeName => _placeName;
  bool get isLoading => _isLoading;
  bool get isCurrentLocationLoading => _isCurrentLocationLoading;
  String? get errorMessage => _errorMessage;
  bool get isLocationServiceDisabled => _isLocationServiceDisabled;
  bool get isPermissionDenied => _isPermissionDenied;

  LocationProvider(BuildContext c) {
    checkLocationAndPermission(c);
  }

  Future<void> checkLocationAndPermission(BuildContext context) async {
    _isProcessing(
      isStarting: true,
    );
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _isProcessing(
          error: 'Location services are disabled.',
          isLocationServiceDisabled: true,
        );
        bool continueProcessing = await _showLocationServiceDialog(context);
        if (!continueProcessing) {
          _isProcessing(isStarting: false);
          return;
        }
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          _isProcessing(
            isStarting: false,
            error: 'Location services are still disabled.',
            isLocationServiceDisabled: true,
          );
          return;
        }
      }

      bool permissionGranted = await _requestLocationPermission(context);
      if (!permissionGranted) {
        _isProcessing(isStarting: false);
        return;
      }
      _isProcessing(
        isStarting: false,
        isLocationServiceDisabled: false,
        isPermissionDenied: false,
      );
    } catch (e) {
      _isProcessing(
        isStarting: false,
        error: 'Failed to check location and permission: $e',
        isPermissionDenied: _isPermissionDenied,
      );
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    _isCurrentLocationLoading=true;
    _isProcessing(isStarting: true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _isProcessing(
          error: 'Location services are disabled.',
          isLocationServiceDisabled: true,
        );
        bool continueProcessing = await _showLocationServiceDialog(context);
        if (!continueProcessing) {
          _isProcessing(isStarting: false);
          return;
        }
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          _isProcessing(
            isStarting: false,
            error: 'Location services are still disabled.',
            isLocationServiceDisabled: true,
          );
          return;
        }
      }

      bool permissionGranted = await _requestLocationPermission(context);
      if (!permissionGranted) {
        _isProcessing(isStarting: false);
        return;
      }
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await _getAddressFromLatLng(_currentPosition!);
      _isProcessing(
        isStarting: false,
        isLocationServiceDisabled: false,
        isPermissionDenied: false,
      );
    } catch (e) {
      _isProcessing(
        isStarting: false,
        error: 'Failed to get location: $e',
        isPermissionDenied: _isPermissionDenied,
      );
    }
  }
  Future<void> updatePosition({required double lat, required double lng}) async {
    _isLoading = true;
    _isPermissionDenied = false;
    _isLocationServiceDisabled = false;
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

  void updatePlaceName({required String placeName}) {
    if (placeName != _placeName) {
      _placeName = placeName;
      notifyListeners();
    }
  }

  void updateCurrentAddress({required String currentAddress}) {
    if (currentAddress != _currentAddress) {
      _currentAddress = currentAddress;
      notifyListeners();
    }
  }

  Future<bool> _showLocationServiceDialog(BuildContext context) async {
    bool continueProcessing = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Enable Location Services'),
          content: const Text('Location services are disabled. Please enable them in your device settings to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                continueProcessing = false;
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                Navigator.of(dialogContext).pop();
                continueProcessing = true;
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
    return continueProcessing;
  }

  Future<bool> _requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      bool? shouldRequestAgain = await _showPermissionDialog(context);
      if (shouldRequestAgain != true) {
        _isProcessing(
          error: 'Location permission denied.',
          isPermissionDenied: true,
        );
        return false;
      }
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      bool? openSettings = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text('Location permissions are permanently denied. Please enable them in app settings.'),
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
      _isProcessing(
        error: 'Location permissions are permanently denied.',
        isPermissionDenied: true,
      );
      return false;
    }
    bool isGranted = permission == LocationPermission.always || permission == LocationPermission.whileInUse;
    _isProcessing(
      isPermissionDenied: !isGranted,
      error: isGranted ? null : 'Location permissions not granted.',
    );
    return isGranted;
  }

  Future<bool?> _showPermissionDialog(BuildContext context) async {
    try {
      return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Grant Location Permission'),
            content: const Text('This app requires location access to function properly. Please allow location permission.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Deny'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Allow'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _isProcessing(
        error: 'Unable to show permission dialog.',
        isPermissionDenied: true,
      );
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
        notifyListeners();
        return;
      }
      Placemark place = placeMarks[4];
      debugPrint("vnirnvirnnrin");
      debugPrint(place.toString());
      _currentAddress = [
        place.thoroughfare,
        place.subLocality,
        place.locality,
        place.postalCode,
        place.country,
      ].where((element) => element != null && element.isNotEmpty).join(', ');
      _placeName = place.name ?? 'Unknown';
      _isCurrentLocationLoading=false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Unable to retrieve address.';
      notifyListeners();
    }
  }

  void _isProcessing({
    bool isStarting = false,
    String? error,
    bool isLocationServiceDisabled = false,
    bool isPermissionDenied = false,
  }) {
    bool hasChanged = false;
    if (_isLoading != isStarting) {
      _isLoading = isStarting;
      hasChanged = true;
    }
    if (_errorMessage != error) {
      _errorMessage = error;
      hasChanged = true;
    }
    if (_isLocationServiceDisabled != isLocationServiceDisabled) {
      _isLocationServiceDisabled = isLocationServiceDisabled;
      hasChanged = true;
    }
    if (_isPermissionDenied != isPermissionDenied) {
      _isPermissionDenied = isPermissionDenied;
      hasChanged = true;
    }
    if (hasChanged) {
      notifyListeners();
    }
  }
}
