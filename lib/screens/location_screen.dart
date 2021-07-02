import 'package:clima_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import '../services/weather.dart';
import '../utilities/customExceptions.dart';

class LocationScreen extends StatefulWidget {
  var locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late double temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  String? errorReason = "";
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData, [String? errorMessage]) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        weatherMessage = 'Unable to get weather data for your city';
        cityName = '';
        errorReason = 'Reason: $errorMessage';
        return;
      }
      temperature = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = '${weather.getMessage(temperature.toInt())} in';
      errorReason = "";
      print(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      try {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      } on LocationServiceEnabledException catch (e) {
                        updateUI(null, e.cause);
                      } on LocationServicePermissionException catch (e) {
                        updateUI(null, e.cause);
                      } on LocationServicePermanentDenialException catch (e) {
                        updateUI(null, e.cause);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage  $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(
                "$errorReason",
                textAlign: TextAlign.center,
                style: kErrorWeatherMessageTextStyle,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
