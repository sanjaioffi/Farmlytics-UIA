// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';
import 'package:uia_hackathon_app/providers/location_provider.dart';
import 'package:uia_hackathon_app/providers/weather_provider.dart';
import 'package:weather/weather.dart';

class LocationManager {
  Future<List<double>> getLatLong() async {
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return [0, 0];
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return [0, 0];
      }
    }
    locationData = await location.getLocation();
    double? lat = locationData.latitude;
    double? long = locationData.longitude;

    return [lat!, long!];
  }

  Future address(BuildContext context) async {
    List<double> latLong = await getLatLong();

    // updating latLong using provider
    Provider.of<LocationProvider>(context, listen: false)
        .updateLocation(latLong);

    // List<geocoding.Placemark> placemarks =
    //     await geocoding.placemarkFromCoordinates(latLong[0], latLong[1]);
    // var address = placemarks[0].toJson();

    // // updating address using provider
    // Provider.of<AddressProvider>(context, listen: false).updateAddress(address);

    // updating weather using provider
    Provider.of<WeatherProvider>(context, listen: false)
        .updateWeather(latLong[0], latLong[1]);

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).popAndPushNamed(MainPage.routeName);
    });
  }
}
