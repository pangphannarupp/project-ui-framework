import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 15,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final isIncome = index % 3 == 0;
          return PPSwipeItem(
            rightActions: [
              PPSwipeAction(
                backgroundColor: Colors.red,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
                },
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              title: Text(isIncome ? 'Salary Deposit' : 'Coffee Shop', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(isIncome ? 'Employer Inc.' : 'Food & Dining', style: TextStyle(color: Colors.grey[600])),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isIncome ? '+\$2,500.00' : '-\$4.50',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isIncome ? Colors.green : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Today', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
