import 'package:flutter/material.dart';
import 'package:testapp1/W7-S2-quizeApp/view/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.title, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage('assets/quize/quiz-logo.png'),
              size: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 30),
            Center(
              child: AppButton(
                "Start Quiz",
                icon: Icons.arrow_forward,
                onTap: onStart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
