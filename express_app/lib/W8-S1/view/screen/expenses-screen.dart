import 'package:express_app/W8-S1/view/widget/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:express_app/W8-S1/model/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => ExpensestState();
}

class ExpensestState extends State<ExpensesScreen> {
  final List<Expense> expenses = [
    Expense(
        title: "book",
        type: ExpenseType.leisure,
        amount: 12,
        date: DateTime.now()),
    Expense(
        title: "milk",
        type: ExpenseType.food,
        amount: 1.5,
        date: DateTime.now()),
    Expense(
        title: "lock lack",
        type: ExpenseType.food,
        amount: 2,
        date: DateTime.now()),
  ];

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close',style: TextStyle(color:Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _showModalBottomSheet(context),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: ExpenseList(
        expenses: expenses,
      ),
    );
  }
}
