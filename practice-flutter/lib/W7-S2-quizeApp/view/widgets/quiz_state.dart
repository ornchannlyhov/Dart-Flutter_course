import 'package:flutter/material.dart';
import 'package:testapp1/W7-S2-quizeApp/model/quiz.dart';
import 'package:testapp1/W7-S2-quizeApp/view/screens/question_screen.dart';
import 'package:testapp1/W7-S2-quizeApp/view/screens/result_screen.dart';
import 'package:testapp1/W7-S2-quizeApp/view/screens/welcome_screen.dart';
import 'package:testapp1/W7-S2-quizeApp/model/submission.dart';

enum QuizState {
  notStarted,
  started,
  finished;

  Widget screen(
    VoidCallback switchState,
    String title,
    Question question, {
    required Quiz quiz,
    required void Function(String selectedAnswer) onAnswerSelected,
    required Submission submission,
    required VoidCallback finishQuizCallback,
    required VoidCallback restartQuiz,
    required VoidCallback skipQuestionCallback,
    required VoidCallback previousQuestionCallback,
    required bool isFirstQuestion,
    required bool isLastQuestion,
  }) {
    switch (this) {
      case QuizState.notStarted:
        return WelcomeScreen(onStart: switchState, title: title);
      case QuizState.started:
        return QuestionScreen(
          onAnswerSelected: onAnswerSelected,
          question: question,
          finishQuizCallback: finishQuizCallback,
          onTap: (String selectedAnswer) {
            onAnswerSelected(selectedAnswer);
          },
          onSkip: skipQuestionCallback,
          onPrevious: previousQuestionCallback,
          isFirstQuestion: isFirstQuestion,
          isLastQuestion: isLastQuestion,
        );
      case QuizState.finished:
        return ResultScreen(
            submission: submission, quiz: quiz, onRestart: restartQuiz);
    }
  }
}
