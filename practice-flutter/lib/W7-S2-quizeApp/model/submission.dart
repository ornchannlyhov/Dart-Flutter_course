import 'package:testapp1/W7-S2-quizeApp/model/quiz.dart';

class Answer {
  String questionAnswer;
  final Question question;

  Answer({required this.questionAnswer, required this.question});

  bool isCorrect() {
    if (question.goodAnswer == questionAnswer) {
      return true;
    }
    return false;
  }
}

class Submission {
  final List<Answer> _answers;

  Submission({required List<Answer> answers}) : _answers = answers;

  List<Answer> get answers => _answers;

  int getScore() {
    int score = 0;
    for (Answer answer in answers) {
      if (answer.isCorrect()) {
        score++;
      }
    }
    return score;
  }

  Answer? getAnswer(Question question) {
    for (Answer answer in answers) {
      if (answer.question == question) {
        return answer;
      }
    }
    return null;
  }

  void addAnswer(Question question, String answer) {
    Answer? existAnswer = getAnswer(question);
    if (existAnswer != null) {
      existAnswer.questionAnswer = answer;
    } else {
      answers.add(Answer(questionAnswer: answer, question: question));
    }
  }

  void removeAnswer(Question question) {
    answers.removeWhere((answer)=>answer.question==question);
  }

  void clearAnswer() {
    answers.clear();
  }
}
