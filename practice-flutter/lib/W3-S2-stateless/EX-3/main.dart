import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Column(children: [ 
      Container(padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              const LinearGradient(colors: [Color(0xff64B5F6), Color(0xff1E88E5)])),
      child: const Center(
        child: Text(
          'OOP',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none),
        ),
      ),
      ),
      Container(padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              const LinearGradient(colors: [Color(0xff64B5F6), Color(0xff1E88E5)])),
      child: const Center(
        child: Text(
          'Dart',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none),
        ),
      ),
      ),
      Container(padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              const LinearGradient(colors: [Color(0xff64B5F6), Color(0xff1E88E5)])),
      child: const Center(
        child: Text(
          'Flutter',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none),
        ),
      ),
      ),],
    ),
  ));
}
