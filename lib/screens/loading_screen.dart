import 'package:flutter/material.dart';
// import '../services/location.dart';
// import '../services/networking.dart';
import '../services/weather.dart';
// import 'dart:convert';
// import '../utilities/constants.dart';
import '../screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final dynamic userLocation;
  LoadingScreen({this.userLocation});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // String? location;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      print("getLocation");
      var weatherData = await weatherModel.getLocationWeather();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SpinKitFadingCircle(
                size: 150.0,
                color: Colors.white,
                duration: const Duration(milliseconds: 2000),
              ),
              Padding(
                padding: EdgeInsets.all(38.0),
                child: Text("fetching your weather data..."),
              )
            ]),
      ),
    );
  }
}
