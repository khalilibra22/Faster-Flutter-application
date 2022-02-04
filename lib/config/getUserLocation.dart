import 'package:Faster/classes/mSystem.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class GetUserLocation {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  GetUserLocation();

  Future grantPermission() async {
    print('Location');
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted != PermissionStatus.granted) return;
    if (_permissionGranted == PermissionStatus.granted) {
      await serviceEnable();
    }
  }

  Future serviceEnable() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }
    if (_serviceEnabled) {
      await getLocation();
      mSystemLocator.userLocation = _locationData;
    }
  }

  Future getLocation() async {
    try {
      _locationData = await location.getLocation();
      print('lat: ${_locationData.latitude}\nlong: ${_locationData.longitude}');
    } catch (e) {
      print('try again');
    }
  }
}
