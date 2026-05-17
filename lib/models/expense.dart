class Expense {
  final String? id;
  final double amount;
  final String category;
  final DateTime date;
  final String? note;

  Expense({
    this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note ?? '',
    };
  }

  factory Expense.fromMap(String id, Map<String, dynamic> map) {
    return Expense(
      id: id,
      amount: (map['amount'] ?? 0).toDouble(),
      category: map['category'],
      date: DateTime.parse(map['date']),
      note: map['note'],
    );
  }
}