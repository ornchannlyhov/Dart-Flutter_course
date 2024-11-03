import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

const List<String> diceImage = [
  'assets/images/dice-1.png',
  'assets/images/dice-2.png',
  'assets/images/dice-3.png',
  'assets/images/dice-4.png',
  'assets/images/dice-5.png',
  'assets/images/dice-6.png',
];

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() => _DiceRoller();
}

class _DiceRoller extends State<DiceRoller> {
  String activateImage = diceImage[0];
  bool isRolling = false;

  void rollDice() {
    if (isRolling) return;
    isRolling = true;

    int rollCount = 0;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        activateImage = diceImage[Random().nextInt(6)];
      });

      rollCount++;
      if (rollCount >= 10) {
        timer.cancel();
        setState(() {
          activateImage = diceImage[Random().nextInt(6)];
          isRolling = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Image.asset(
            activateImage,
            key: ValueKey<String>(activateImage),
            width: 200,
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll'),
        ),
      ],
    );
  }
}

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Center(child: DiceRoller()),
      ),
    ));
