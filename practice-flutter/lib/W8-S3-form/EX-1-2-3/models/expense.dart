import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food('FOOD', Icons.lunch_dining),
  travel('TRAVEL', Icons.flight_takeoff),
  leisure('LEISURE', Icons.movie),
  work('WORK', Icons.work);

  final String label;
  final IconData icon;
  const Category(this.label, this.icon);
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  @override
  String toString() {
    return "Expense $title , amount $amount";
  }
}
