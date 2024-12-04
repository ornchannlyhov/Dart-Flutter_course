import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category? selectedCategory;
  DateTime selectedDate = DateTime.now();

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onAdd() {
    String title = _titleController.text;
    double? amount = double.tryParse(_valueController.text);

    final bool titleValid = title.trim().isNotEmpty;
    final bool amountValid = amount != null && amount > 0;
    final bool valid = titleValid && amountValid;
    if (valid) {
      Expense expense = Expense(
          title: title,
          amount: amount,
          date: selectedDate,
          category: selectedCategory!);

      widget.onCreated(expense);

      Navigator.pop(context);
    } else {
      final message = !titleValid
          ? 'The title cannot be empty'
          : 'The amount must be a valid number greater than 0';
      showMessageDialog(context, message);
    }
  }

  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void setCategory(Category? newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

  Future<void> setDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  ],
                  controller: _valueController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    prefix: Text('\$ '),
                    label: Text('Amount'),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(DateFormat.yMd().format(selectedDate)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  IconButton(
                      onPressed: () => setDate(context),
                      icon: const Icon(Icons.edit_calendar)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<Category>(
                value: selectedCategory,
                hint: const Text('Select a category'),
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.label),
                        ))
                    .toList(),
                onChanged: setCategory,
              ),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: onAdd, child: const Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}
