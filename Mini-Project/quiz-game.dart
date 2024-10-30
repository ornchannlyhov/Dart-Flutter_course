import 'dart:convert';
import 'dart:io';

enum QuestionType { SINGLE_CHOICE, MULTIPLE_CHOICE }

class Question {
  String title;
  List<String> options;
  List<String> correctAnswers;
  QuestionType questionType;

  Question(this.title, this.options, this.correctAnswers, this.questionType);

  bool isAnswerCorrect(List<String> answers) {
    if (questionType == QuestionType.SINGLE_CHOICE) {
      return answers.length == 1 && correctAnswers.contains(answers.first);
    } else if (questionType == QuestionType.MULTIPLE_CHOICE) {
      return answers.toSet().containsAll(correctAnswers.toSet()) &&
          correctAnswers.toSet().containsAll(answers.toSet());
    }
    return false;
  }

  void displayQuestion() {
    print('\n$title');
    for (var i = 0; i < options.length; i++) {
      print('${i + 1}. ${options[i]}'); 
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'options': options,
      'correctAnswers': correctAnswers,
      'questionType': questionType.toString().split('.').last,
    };
  }

  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      json['title'],
      List<String>.from(json['options']),
      List<String>.from(json['correctAnswers']),
      QuestionType.values.firstWhere(
          (e) => e.toString().split('.').last == json['questionType']),
    );
  }
}

class Participant {
  String id;
  String firstName;
  String lastName;
  List<Result> results = [];

  Participant(this.id, this.firstName, this.lastName);

  void addResult(Result r) {
    results.add(r);
  }

  bool hasTakenQuiz(String quizTitle) {
    return results.any((result) => result.quizTitle == quizTitle);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }

  static Participant fromJson(Map<String, dynamic> json) {
    Participant participant =
        Participant(json['id'], json['firstName'], json['lastName']);
    participant.results = List<Result>.from(
        json['results'].map((result) => Result.fromJson(result)));
    return participant;
  }
}

class Result {
  int score;
  String quizTitle;
  DateTime date;

  Result(this.score, this.quizTitle, this.date);

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'quizTitle': quizTitle,
      'date': date.toIso8601String(),
    };
  }

  static Result fromJson(Map<String, dynamic> json) {
    return Result(
      json['score'],
      json['quizTitle'],
      DateTime.parse(json['date']),
    );
  }
}

class Quiz {
  String title;
  List<Question> questions = [];

  Quiz(this.title);

  void addQuestion(Question q) {
    questions.add(q);
  }

  void deleteQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
    } else {
      print("Invalid question number.");
    }
  }

  Result takeQuiz(Participant participant) {
    int score = 0;

    for (var question in questions) {
      question.displayQuestion(); // Display the question and its options

      List<String> selectedAnswers = [];

      if (question.questionType == QuestionType.SINGLE_CHOICE) {
        stdout.write("Select one answer (or type 'cancel' to exit): ");
        String answer = stdin.readLineSync()!;
        if (answer.toLowerCase() == 'cancel') return Result(0, title, DateTime.now());
        selectedAnswers.add(answer);
      } else if (question.questionType == QuestionType.MULTIPLE_CHOICE) {
        stdout.write("Select multiple answers (comma-separated, or type 'cancel' to exit): ");
        String answerInput = stdin.readLineSync()!;
        if (answerInput.toLowerCase() == 'cancel') return Result(0, title, DateTime.now());
        selectedAnswers.addAll(answerInput.split(',').map((a) => a.trim()));
      }

      if (question.isAnswerCorrect(selectedAnswers)) {
        score++;
      }
    }

    Result result = Result(score, title, DateTime.now());
    participant.addResult(result);
    return result;
  }

  void displayQuestions() {
    print("\nAvailable Questions:");
    for (var i = 0; i < questions.length; i++) {
      print('${i + 1}. ${questions[i].title}'); // Display all questions with numbers
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  static Quiz fromJson(Map<String, dynamic> json) {
    Quiz quiz = Quiz(json['title']);
    quiz.questions = List<Question>.from(json['questions'].map((q) => Question.fromJson(q)));
    return quiz;
  }
}

class QuizSystem {
  List<Participant> participants = [];
  Quiz quiz;

  QuizSystem(this.quiz);

  void run() {
    loadParticipants();
    loadQuestions();

    while (true) {
      print("\nOptions:");
      print("1. Take Quiz");
      print("2. Add Question");
      print("3. View Results");
      print("4. Delete Question");
      print("5. Exit");
      stdout.write("Choose an option: ");
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          takeQuiz();
          break;
        case '2':
          addQuestion();
          break;
        case '3':
          viewResults();
          break;
        case '4':
          deleteQuestion();
          break;
        case '5':
          saveParticipants();
          saveQuestions();
          print("Exiting...");
          return;
        default:
          print("Invalid option. Please choose again.");
      }
    }
  }

  void takeQuiz() {
    if (quiz.questions.isEmpty) {
      print("No questions available. Please add questions before taking the quiz.");
      return;
    }

    stdout.write("Enter your first name (or type 'cancel' to go back): ");
    String firstName = stdin.readLineSync()!;
    if (firstName.toLowerCase() == 'cancel') return;

    stdout.write("Enter your last name (or type 'cancel' to go back): ");
    String lastName = stdin.readLineSync()!;
    if (lastName.toLowerCase() == 'cancel') return;

    String participantId = "${firstName.toLowerCase()}_${lastName.toLowerCase()}";
    Participant? participant = participants.firstWhere(
      (p) => p.id == participantId,
      orElse: () {
        Participant newParticipant = Participant(participantId, firstName, lastName);
        participants.add(newParticipant);
        return newParticipant;
      },
    );

    if (participant.hasTakenQuiz(quiz.title)) {
      stdout.write("You have already taken this quiz. Do you want to start over? (y/n): ");
      String? response = stdin.readLineSync();
      if (response?.toLowerCase() != 'y') {
        print("Continuing with existing results...");
        return;
      }
    }

    Result result = quiz.takeQuiz(participant);
    print("You scored ${result.score} out of ${quiz.questions.length}.");
    saveParticipants(); // Save participant results after taking the quiz
  }

  void addQuestion() {
    stdout.write("Enter the question title (or type 'cancel' to go back): ");
    String title = stdin.readLineSync()!;
    if (title.toLowerCase() == 'cancel') return;

    stdout.write("Enter the question type (1 for SINGLE_CHOICE, 2 for MULTIPLE_CHOICE): ");
    String? typeChoice = stdin.readLineSync();
    QuestionType questionType = (typeChoice == '1')
        ? QuestionType.SINGLE_CHOICE
        : QuestionType.MULTIPLE_CHOICE;

    List<String> options = [];
    while (true) {
      stdout.write("Enter an option (or type 'done' when finished): ");
      String option = stdin.readLineSync()!;
      if (option.toLowerCase() == 'done') break;
      options.add(option);
    }

    stdout.write("Enter the correct answers (comma-separated): ");
    List<String> correctAnswers = stdin.readLineSync()!.split(',').map((s) => s.trim()).toList();

    Question question = Question(title, options, correctAnswers, questionType);
    quiz.addQuestion(question);

    // Save the question immediately to persist data
    saveQuestions();
    print("Question added and saved successfully!");
  }

  void viewResults() {
    stdout.write("Enter participant ID (first_last format, or type 'cancel' to go back): ");
    String participantId = stdin.readLineSync()!;
    if (participantId.toLowerCase() == 'cancel') return;

    Participant participant = participants.firstWhere(
      (p) => p.id == participantId,
      orElse: () {
        print("Participant not found.");
        return Participant('', '', ''); // Returning a dummy participant to prevent errors
      },
    );

    print("\nResults for ${participant.firstName} ${participant.lastName}:");
    for (var result in participant.results) {
      print("Quiz: ${result.quizTitle}, Score: ${result.score}, Date: ${result.date}");
    }
  }

  void deleteQuestion() {
    quiz.displayQuestions(); // Display questions with numbers
    stdout.write("Enter the question number to delete (or type 'cancel' to go back): ");
    String input = stdin.readLineSync()!;
    if (input.toLowerCase() == 'cancel') return;

    int questionNumber = int.tryParse(input) ?? 0;
    quiz.deleteQuestion(questionNumber - 1); // Adjust for zero-based index
    saveQuestions(); // Save changes immediately
    print("Question deleted successfully!");
  }

  void loadParticipants() {
    File participantsFile = File('participants.json');
    if (participantsFile.existsSync()) {
      String contents = participantsFile.readAsStringSync();
      List<dynamic> jsonList = jsonDecode(contents);
      participants = jsonList.map((json) => Participant.fromJson(json)).toList();
    }
  }

  void saveParticipants() {
    File participantsFile = File('participants.json');
    String jsonString = jsonEncode(participants.map((p) => p.toJson()).toList());
    participantsFile.writeAsStringSync(jsonString);
  }

  void loadQuestions() {
    File quizFile = File('quiz.json');
    if (quizFile.existsSync()) {
      String contents = quizFile.readAsStringSync();
      quiz = Quiz.fromJson(jsonDecode(contents));
    }
  }

  void saveQuestions() {
    File quizFile = File('quiz.json');
    String jsonString = jsonEncode(quiz.toJson());
    quizFile.writeAsStringSync(jsonString);
  }
}

void main() {
  Quiz quiz = Quiz("General Knowledge Quiz");
  QuizSystem quizSystem = QuizSystem(quiz);
  quizSystem.run();
}
