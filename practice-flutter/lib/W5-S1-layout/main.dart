import 'package:flutter/material.dart';

List<String> dayOfWeek = ['Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat', 'Sun'];
void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(title: const Text('Loop in array'),backgroundColor: Colors.blue,),
    body: Column(
      children: [
        Container(
            child: Column(
          children: [
            const Text('Start'),
            for(var i = 0; i<=6;i++) Text(dayOfWeek[i]),
            const Text('End'),
          ],
        )),
      ],
    ),
  )));
}
