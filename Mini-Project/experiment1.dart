import 'dart:io';
import 'dart:convert';

void main() {
  List<Quiz> quizzes = loadQuizzes('quizzes.json');
  List<Participant> participants = loadParticipants('participants.json');

  while (true) {
    print('Welcome to the Quiz Application');
    print('1. Create a Quiz');
    print('2. Participate in a Quiz');
    print('3. View Scores');
    print('4. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createQuiz(quizzes);
        break;
      case '2':
        participateInQuiz(quizzes, participants);
        break;
      case '3':
        viewScores(participants);
        break;
      case '4':
        saveParticipants(participants, 'participants.json');
        saveQuizzes(quizzes, 'quizzes.json');
        print('Goodbye!');
        return;
      default:
        print('Invalid option, please try again.');
    }
  }
}

class Participant {
  String firstName;
  String lastName;
  List<QuizResult> quizResults = []; // Store quiz results

  Participant(this.firstName, this.lastName);

  String getFullName() => '$firstName $lastName';
}

class QuizResult {
  String quizTitle;
  int score;

  QuizResult(this.quizTitle, this.score);
}

class Quiz {
  String title;
  List<Question> questions = [];
  List<Participant> participants = []; 
  Quiz(this.title);

  void addQuestion(Question question) {
    questions.add(question);
  }

  int calculateResult(Participant participant) {
    int score = 0;
    for (var question in questions) {
      stdout.write('${question.title}\n');
      question.displayOptions();
      stdout.write('Your answer: ');
      String? answer = stdin.readLineSync();
      if (question.checkAnswer(answer)) {
        score++;
      }
    }
    participant.quizResults.add(QuizResult(title, score));
    return score;
  }
}

abstract class Question {
  String title;
  List<String> options;

  Question(this.title, this.options);

  void displayOptions() {
    for (var i = 0; i < options.length; i++) {
      print('${i + 1}. ${options[i]}');
    }
  }

  bool checkAnswer(String? answer);
}

class SingleChoiceQuestion extends Question {
  String correctAnswer;

  SingleChoiceQuestion(String title, List<String> options, this.correctAnswer)
      : super(title, options);

  @override
  bool checkAnswer(String? answer) {
    return answer == correctAnswer;
  }
}

class MultipleChoiceQuestion extends Question {
  List<String> correctAnswers;

  MultipleChoiceQuestion(String title, List<String> options, this.correctAnswers)
      : super(title, options);

  @override
  bool checkAnswer(String? answer) {
    return correctAnswers.contains(answer);
  }
}

// Function to create a quiz
void createQuiz(List<Quiz> quizzes) {
  stdout.write('Enter quiz title: ');
  String title = stdin.readLineSync()!;
  Quiz quiz = Quiz(title);

  while (true) {
    stdout.write('Enter question title (or "done" to finish): ');
    String questionTitle = stdin.readLineSync()!;
    if (questionTitle.toLowerCase() == 'done') break;

    stdout.write('Enter options (comma-separated): ');
    List<String> options = stdin.readLineSync()!.split(',');

    stdout.write('Is this a single-choice question? (y/n): ');
    String type = stdin.readLineSync()!;
    if (type.toLowerCase() == 'y') {
      stdout.write('Enter the correct answer: ');
      String correctAnswer = stdin.readLineSync()!;
      quiz.addQuestion(SingleChoiceQuestion(questionTitle, options, correctAnswer));
    } else {
      stdout.write('Enter correct answers (comma-separated): ');
      List<String> correctAnswers = stdin.readLineSync()!.split(',');
      quiz.addQuestion(MultipleChoiceQuestion(questionTitle, options, correctAnswers));
    }
  }

  quizzes.add(quiz);
  print('Quiz "$title" created successfully!\n');
}

// Function to participate in a quiz
void participateInQuiz(List<Quiz> quizzes, List<Participant> participants) {
  if (quizzes.isEmpty) {
    print('No quizzes available. Please create a quiz first.\n');
    return;
  }

  stdout.write('Do you want to enter your full name (1) or are you already registered (2)? ');
  String? registrationChoice = stdin.readLineSync();

  Participant? participant;

  if (registrationChoice == '1') {
    // Register participant
    stdout.write('Enter your first name: ');
    String firstName = stdin.readLineSync()!;
    stdout.write('Enter your last name: ');
    String lastName = stdin.readLineSync()!;
    participant = Participant(firstName, lastName);

    // Check if participant already exists
    if (participants.any((p) => p.getFullName() == participant?.getFullName())) {
      print('You are already registered as ${participant.getFullName()}.');
      return;
    }

    participants.add(participant);
    print('Registration successful! Welcome ${participant.getFullName()}!\n');
  } else if (registrationChoice == '2') {
    // Verify registered participant
    bool found = false; // Track if participant is found
    while (!found) {
      stdout.write('Enter your full name: ');
      String fullName = stdin.readLineSync()!;

      // Attempt to find the participant
      participant = participants.firstWhere(
        (p) => p.getFullName() == fullName,
        orElse: () => null!, // Returns null if not found
      );

      if (participant != null) {
        found = true; // If participant is found, exit the loop
        print('Welcome back, ${participant.getFullName()}!\n');
      } else {
        print('Participant not found. Please try again or register.');
      }
    }
  }

  // Check if participant has taken any quizzes before
  if (participant!.quizResults.isNotEmpty) {
    stdout.write('You have already participated in some quizzes. Would you like to (1) continue or (2) restart? ');
    String? continueChoice = stdin.readLineSync();

    if (continueChoice == '1') {
      print('You will continue from your previous quizzes.\n');
    } else {
      participant.quizResults.clear(); // Clear previous results
      print('You chose to restart. Starting a new quiz...\n');
    }
  }

  // Proceed to take the quiz
  for (var quiz in quizzes) {
    int score = quiz.calculateResult(participant); // Calculate score for each quiz
    print('Your score for "${quiz.title}": $score\n');
  }
}

// Function to view scores of participants
void viewScores(List<Participant> participants) {
  if (participants.isEmpty) {
    print('No participants available.\n');
    return;
  }

  print('Scores of Participants:');
  for (var participant in participants) {
    print('${participant.getFullName()}:');
    for (var result in participant.quizResults) {
      print('  Quiz: ${result.quizTitle}, Score: ${result.score}');
    }
    print('');
  }
}

// Load quizzes from a JSON file
List<Quiz> loadQuizzes(String filePath) {
  // Implement loading quizzes from a file
  return []; // Replace with actual loading logic
}

// Load participants from a JSON file
List<Participant> loadParticipants(String filePath) {
  // Implement loading participants from a file
  return []; // Replace with actual loading logic
}

// Save participants to a JSON file
void saveParticipants(List<Participant> participants, String filePath) {
  // Implement saving participants to a file
}

// Save quizzes to a JSON file
void saveQuizzes(List<Quiz> quizzes, String filePath) {
  // Implement saving quizzes to a file
}
