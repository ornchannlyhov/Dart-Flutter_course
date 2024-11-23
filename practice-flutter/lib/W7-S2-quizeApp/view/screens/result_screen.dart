import 'package:flutter/material.dart';
import 'package:testapp1/W7-S2-quizeApp/model/quiz.dart';
import 'package:testapp1/W7-S2-quizeApp/model/submission.dart';
import 'package:testapp1/W7-S2-quizeApp/view/widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final Submission submission;
  final Quiz quiz;
  final void Function() onRestart;

  const ResultScreen({
    required this.submission,
    required this.quiz,
    required this.onRestart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int score = submission.getScore();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "You answered $score/${quiz.questions.length} correctly!",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  final userAnswer = submission.getAnswer(question);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: userAnswer!.isCorrect()
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            child: Text("${index + 1}",
                                style: const TextStyle(color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              question.title,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: question.possibleAnswers.map((option) {
                          Color textColor = Colors.black;
                          FontWeight fontWeight = FontWeight.normal;

                          if (option == userAnswer.questionAnswer &&
                              userAnswer.isCorrect()) {
                            textColor = Colors.green;
                            fontWeight = FontWeight.bold;
                          } else if (option == userAnswer.questionAnswer &&
                              !userAnswer.isCorrect()) {
                            textColor = Colors.red;
                            fontWeight = FontWeight.bold;
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 4),
                            child: Text(
                              option,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: fontWeight,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  );
                },
              ),
            ),
            Center(
              child: AppButton(
                "Restart Quiz",
                icon: Icons.refresh,
                onTap: onRestart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
