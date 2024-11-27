import 'package:uuid/uuid.dart';

enum ExpenseType { food, travel, leisure, work }

class Expense {
  static Uuid uuid = const Uuid();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType type;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.type})
      : id = uuid.v4();
}
