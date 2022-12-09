import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  List<double> _latLong = [0, 0];
  List<double> get latLong => _latLong;

  void updateLocation(List<double> currentLatLong) {
    _latLong = currentLatLong;
    notifyListeners();
  }
}

class AddressProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  Map _address = {};
  Map get address => _address;

  void updateAddress(Map currentAddress) {
    _address = currentAddress;
    notifyListeners();
  }
}
