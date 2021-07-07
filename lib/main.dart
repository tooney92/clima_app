import 'package:flutter/material.dart';
// import 'package:clima_app/screens/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_app/screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
