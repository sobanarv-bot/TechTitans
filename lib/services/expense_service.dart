import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseService {
  final _db = FirebaseFirestore.instance.collection('expenses');

  Future<void> addExpense(Expense expense) async {
    await _db.add(expense.toMap());
  }

  Stream<List<Expense>> getExpenses() {
    return _db.orderBy('date', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Expense.fromMap(doc.id, doc.data());
        }).toList();
      },
    );
  }
}