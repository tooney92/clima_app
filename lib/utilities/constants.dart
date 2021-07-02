import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

String? apiKey = dotenv.env['apiKey'];

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
);

const kErrorWeatherMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 20.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
