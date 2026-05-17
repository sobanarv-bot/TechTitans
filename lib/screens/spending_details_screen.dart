import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../services/expense_service.dart';
import '../models/expense.dart';

class SpendingDetails extends StatelessWidget {
  SpendingDetails({super.key});

  final ExpenseService service = ExpenseService();

  Map<String, double> groupData(List<Expense> expenses) {
    final map = <String, double>{};

    for (var e in expenses) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses Analytics")),
      body: StreamBuilder<List<Expense>>(
        stream: service.getExpenses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final expenses = snapshot.data!;
          final grouped = groupData(expenses);

          return Column(
            children: [
              // 📊 PIE CHART
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: grouped.entries.map((e) {
                      return PieChartSectionData(
                        value: e.value,
                        title: e.key,
                        radius: 60,
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 📜 HISTORY LIST
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final e = expenses[index];

                    return ListTile(
                      leading: const Icon(Icons.receipt),
                      title: Text("RM ${e.amount.toStringAsFixed(2)}"),
                      subtitle: Text(e.category),
                      trailing: Text(
                        "${e.date.day}/${e.date.month}",
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}