import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Container(
          height: 200,
          color: Colors.blue,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              height: 100,
              color: Colors.green,
            )),
            Container(
              height: 100,
              width: 100,
              color: Colors.pink,
            ), 
          ],
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.orange,
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.orange,
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.orange,
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          color: Colors.pink,
        ))
      ]),
    ),
  ));
}
