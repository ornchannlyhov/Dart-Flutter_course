import 'package:flutter/material.dart';
import 'screen/device_converter.dart';
 
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 20, 61, 121),
                Color.fromARGB(255, 176, 159, 159),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const DeviceConverter(),
        ),
      ),
    ));
}
