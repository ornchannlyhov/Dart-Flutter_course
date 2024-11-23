import 'package:testapp1/W7-S2-quizeApp/model/quiz.dart';
import 'package:testapp1/W7-S2-quizeApp/model/submission.dart';

void main() {
  Question q1 = const Question(
    title: "Who is the best teacher?",
    possibleAnswers: ["ronan", "hongly", 'leangsiv'],
    goodAnswer: 'ronan',
  );
  Question q2 = const Question(
    title: "Which color is the best?",
    possibleAnswers: ["blue", "red", 'green'],
    goodAnswer: 'red',
  );
  Question q3 = const Question(
    title: "What is the best group?",
    possibleAnswers: ["g1", "g2", "g3"],
    goodAnswer: 'g2',
  );

  Answer a1 = Answer(questionAnswer: 'ronan', question: q1); 
  Answer a2 = Answer(questionAnswer: 'blue', question: q2);  

  print("Answer a1 is correct: ${a1.isCorrect()}"); 
  print("Answer a2 is correct: ${a2.isCorrect()}"); 

  List<Answer> myAnswers = [a1, a2];
  Submission s1 = Submission(answers: myAnswers);

  print("Your score is: ${s1.getScore()} out of ${myAnswers.length}"); 

  Answer? retrievedAnswer = s1.getAnswer(q1);
  print("The answer for q1 is: ${retrievedAnswer?.questionAnswer}"); 

  Answer? missingAnswer = s1.getAnswer(q3);
  print("The answer for q3 is: ${missingAnswer?.questionAnswer ?? 'No answer'}"); 

  s1.addAnswer(q3, "g2");
  print("Added answer for q3. Total answers: ${s1.answers.length}"); 

  s1.clearAnswer();
  print("Removed answer. Total answers: ${myAnswers.length}");

}
