import 'package:flutter/material.dart';
import 'package:testapp1/W7-S2-quizeApp/model/quiz.dart';
import 'package:testapp1/W7-S2-quizeApp/view/widgets/app_button.dart';

class QuestionScreen extends StatelessWidget {
  final void Function(String) onTap;
  final VoidCallback onSkip;
  final VoidCallback onPrevious;
  final Question question;
  final bool isFirstQuestion;
  final bool isLastQuestion;

  const QuestionScreen({
    required this.onTap,
    required this.question,
    required this.onSkip,
    required this.onPrevious,
    required this.isFirstQuestion,
    required this.isLastQuestion,
    super.key, required void Function(String selectedAnswer) onAnswerSelected, required VoidCallback finishQuizCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                question.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ...question.possibleAnswers.map(
                (option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onTap(option);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 40,
                      ),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isFirstQuestion)
                    AppButton('', icon: Icons.arrow_back, onTap: onPrevious),
                  if (!isLastQuestion)
                    AppButton('', icon: Icons.arrow_forward, onTap: onSkip),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
