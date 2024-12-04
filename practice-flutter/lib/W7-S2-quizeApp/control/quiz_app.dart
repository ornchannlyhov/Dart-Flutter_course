import 'package:flutter/material.dart';
import 'package:testapp1/W7-S2-quizeApp/model/submission.dart';
import 'package:testapp1/W7-S2-quizeApp/view/widgets/quiz_state.dart';
import '../model/quiz.dart';

Color appColor = Colors.blue[500] as Color;

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  const QuizApp({required this.quiz, super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  int currentQuestionIndex = 0;
  final Submission submission = Submission(answers: []);

  void setQuizState(QuizState state) {
    setState(() {
      quizState = state;
    });
  }

  void takeQuiz(String selectedAnswer) {
    setState(() {
      Question currentQuestion = widget.quiz.questions[currentQuestionIndex];
      submission.addAnswer(currentQuestion, selectedAnswer);
      if (currentQuestionIndex == widget.quiz.questions.length - 1) {
        setQuizState(QuizState.finished);
      } else {
        currentQuestionIndex++;
      }
    });
  }

  void finishQuiz() {
    setState(() {
      setQuizState(QuizState.finished);
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      setQuizState(QuizState.notStarted);
      submission.clearAnswer();
    });
  }

  void skipQuestion() {
    setState(() {
      Question currentQuestion = widget.quiz.questions[currentQuestionIndex];
      if (currentQuestionIndex < widget.quiz.questions.length - 1) {
        submission.addAnswer(currentQuestion, '');
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[500] as Color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: quizState.screen(
                  () => setQuizState(QuizState.started),
                  widget.quiz.title,
                  widget.quiz.questions[currentQuestionIndex],
                  quiz: widget.quiz,
                  onAnswerSelected: takeQuiz,
                  submission: submission,
                  finishQuizCallback: finishQuiz,
                  restartQuiz: restartQuiz,
                  skipQuestionCallback: skipQuestion,
                  previousQuestionCallback: previousQuestion,
                  isFirstQuestion: currentQuestionIndex == 0,
                  isLastQuestion:
                      currentQuestionIndex == widget.quiz.questions.length - 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
