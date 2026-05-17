import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/ocr_service.dart';
import '../services/expense_service.dart';
import '../models/expense.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  final OCRService _ocr = OCRService();
  final ExpenseService _service = ExpenseService();

  bool loading = false;

  Future<void> scanReceipt() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() => loading = true);

    final file = File(image.path);

    final text = await _ocr.extractText(file);
    final amount = _ocr.extractTotalAmount(text);
    final category = _ocr.guessCategory(text);

    if (amount != null) {
      final expense = Expense(
        id: '',
        amount: amount,
        category: category,
        date: DateTime.now(),
      );

      await _service.addExpense(expense);
    }

    setState(() => loading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Expense saved successfully!")),
      );
    }
  }

  @override
  void dispose() {
    _ocr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Receipt")),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: scanReceipt,
                child: const Text("Scan Receipt"),
              ),
      ),
    );
  }
}