import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final int startColor;
  final int endColor;
  final String buttonName;

  const MyButton(
      {super.key,
      required this.buttonName,
      required this.startColor,
      required this.endColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              LinearGradient(colors: [Color(startColor), Color(endColor)])),
      child: Center(
        child: Text(
          buttonName,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Container(
      child: const Scaffold(
        body: Center(
          child: Column(
            children: [
              MyButton(
                  buttonName: 'OOP',
                  startColor: 0xff64B5F6,
                  endColor: 0xff1E88E5),
              MyButton(
                  buttonName: 'Dart',
                  startColor: 0xff64B5F6,
                  endColor: 0xff1E88E5),
              MyButton(
                  buttonName: 'Flutter',
                  startColor: 0xff64B5F6,
                  endColor: 0xff1E88E5),
            ],
          ),
        ),
      ),
    ),
  ));
}
