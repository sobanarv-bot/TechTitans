import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../services/expense_service.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final ExpenseService _service = ExpenseService();

  String selectedCategory = "Food";
  bool loading = false;

  final List<String> categories = [
    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Other",
  ];

  Future<void> addExpense() async {
    if (_amountController.text.isEmpty) return;

    setState(() => loading = true);

    final expense = Expense(
      amount: double.parse(_amountController.text),
      category: selectedCategory,
      date: DateTime.now(),
      note: _noteController.text,
    );

    await _service.addExpense(expense);

    setState(() => loading = false);

    _amountController.clear();
    _noteController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense added successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount (RM)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: "Note (optional)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : addExpense,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Expense"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}