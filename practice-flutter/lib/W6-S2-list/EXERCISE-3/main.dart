import 'package:flutter/material.dart';
import 'package:testapp1/W6-S2-list/EXERCISE-3/screen/welcome.dart';
import 'package:testapp1/W6-S2-list/EXERCISE-3/screen/temperature.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool isWelcomeScreen = true;

  void switchToTemperatureScreen() {
    setState(() {
      isWelcomeScreen = false;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isWelcomeScreen
              ? Welcome(onButtonPressed: switchToTemperatureScreen)
              : Temperature()
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
