import 'package:api_weatherapp/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:api_weatherapp/utilities/constants.dart';

import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int humidity = 0, pressure = 0, visibility = 0, temp = 0;
  String weather = "", country = "";
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    print("---------------------------------");
    updateUI(widget.locationWeather);
  }

  String weathericon = " ", tempinfo = ""; // text info

  void updateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        return;
      }
      double tempr = weatherdata["main"]["temp"];
      temp = tempr.toInt();
      weather = weatherdata["weather"][0]["main"];
      humidity = weatherdata["main"]["humidity"];
      pressure = weatherdata["main"]["pressure"];
      country = weatherdata["sys"]["country"];
      visibility = weatherdata["visibility"];
      weathericon =
          weatherModel.getWeatherIcon(weatherdata["weather"][0]["id"]);
      tempinfo = weatherModel.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            //   colorFilter: ColorFilter.mode(
            //       Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getLocationWeather();

                      updateUI(weatherdata);
                    },
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return CityScreen();
                          }),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                // color: Colors.amber,
                height: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$temp',
                      style: kTempTextStyle,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      weathericon,
                      style: TextStyle(fontSize: 70.0),
                    ),
                  ],
                ),
              ),
              Text(
                "$tempinfo in $country",
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
