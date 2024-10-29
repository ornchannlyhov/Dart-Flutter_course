//Question type
enum QuestionType {
  SINGLE_CHOICE("single_choice"),
  MULTIPLE_CHOICE("multiple choice");

  final String label;
  const QuestionType(this.label);
  @override
  String toString() => '$label';
}

//Participant
class Participant {
  final String firstName;
  final String lastName;
  final Map<Quiz, int> quizResults;

  Participant(this.firstName, this.lastName) : quizResults = {};

  String get fullName => '$firstName $lastName';
}

//Question
class Question {
  final String title;
  final String question;
  QuestionType questionType;
  final List<String> options;
  final List<int> answers;

  Question(this.title, this.question, this.questionType)
      : options = [],
        answers = [];
  // set question typ
  void setQuestionType(int choice) {
    this.questionType =
        choice == 1 ? QuestionType.SINGLE_CHOICE : QuestionType.MULTIPLE_CHOICE;
  }

  //add options
  void addOption(String option) {
    options.add(option);
  }

  //add correct answer
  void addAnswer(int answer) {
    answers.add(answer);
  }
}

// Quiz
class Quiz {
  final List<Question> questions;
  final List<Participant> participants;
  final String title;

  Quiz(this.title)
      : questions = [],
        participants = [];
}
