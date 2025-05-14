import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {

  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  LatLng _defaultLatLng = const LatLng(19.075109356298743, 72.87724585652764);
  LatLng _draggedLatLng = const LatLng(0.0, 0.0);
  String _draggedAddress = "";
  String _placeName = "";
  String _mapStyle = "";
  Placemark? _address;
  bool isLoading=true;
  List<Placemark>? _placeMarks;

  CameraPosition? get cameraPosition => _cameraPosition;
  String get draggedAddress => _draggedAddress;
  String get placeName => _placeName;
  LatLng get draggedLatLng => _draggedLatLng;

  MapProvider() {
    _init();
    _gotoUserCurrentPosition();
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
      notifyListeners();
    });
  }

  Future<void> _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    await _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  void _init() {
    _defaultLatLng = const LatLng(0.0, 0.0);
    _draggedLatLng = _defaultLatLng;
    _cameraPosition = CameraPosition(target: _defaultLatLng, zoom: 17.8);
  }

  Future<void> _getAddress(LatLng position) async {
     isLoading=true;
     notifyListeners();
    _placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    _address = _placeMarks![4];
    _draggedAddress = "${_address!.street}, ${_address!.locality}, ${_address!.administrativeArea}, ${_address!.country}";
    _placeName = _address!.name ?? 'Unknown';
    isLoading=false;
    notifyListeners();
  }

  Future<void> gotoUserCurrentPosition() async {
    EasyLoading.show(status: "Fetching location...", dismissOnTap: false, maskType: EasyLoadingMaskType.black);
    Position currentPosition = await _determineUserCurrentPosition();
    await _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));
    EasyLoading.dismiss();
  }

  Future<void> _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 18)));
    await _getAddress(position);
  }

  Future<Position> _determineUserCurrentPosition() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      debugPrint("Location services disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permission denied forever");
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void onCameraMove(CameraPosition position) {
    _draggedLatLng = position.target;
    notifyListeners();
  }

  void onCameraIdle() {
    _getAddress(_draggedLatLng);
  }

  void onMapCreated(GoogleMapController controller) {
    if (!_googleMapController.isCompleted) {
      _googleMapController.complete(controller);
      controller.setMapStyle(_mapStyle);
    }
  }
}
