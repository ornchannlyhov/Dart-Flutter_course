import 'package:flutter/material.dart';
// test 
void main() {
  runApp(MaterialApp(
    home: Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.blue.shade300, borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            color: Colors.blue.shade600,
            borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    ),
  ));
}
