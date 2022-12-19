// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:api_weatherapp/screens/location_screen.dart';
import 'package:api_weatherapp/services/networking.dart';
import 'package:api_weatherapp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void checkpermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    // permission = await Geolocato.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print(permission);
  }

  //  CONSTANTS

  void getlocation() async {
    var weatherdata = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => LocationScreen(
              locationWeather: weatherdata,
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getlocation();
    print("init is working init");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
        ),
      ),
    );
  }
}
