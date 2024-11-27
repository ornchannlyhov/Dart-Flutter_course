import 'package:flutter/material.dart';
import 'package:express_app/model/expense.dart';
import 'expense_items.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItems(expense: expenses[index]),
    );
  }
}
