import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/debt.dart';
import '../providers/debt_provider.dart';

class DebtDetailScreen extends ConsumerWidget {
  final Debt debt;
  const DebtDetailScreen({super.key, required this.debt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debt Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Person: ${debt.personName}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              debt.type == 'money'
                  ? 'Amount: \$${debt.amount?.toStringAsFixed(2) ?? '0.00'}'
                  : 'Item: ${debt.itemName ?? ''}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Date Lent: ${debt.dateLent.toLocal()}',
                style: const TextStyle(fontSize: 16)),
            if (debt.notes != null) ...[
              const SizedBox(height: 8),
              Text('Notes: ${debt.notes}', style: const TextStyle(fontSize: 16)),
            ],
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(debtListProvider.notifier).updateDebt(
                  debt..isSettled = !debt.isSettled,
                );
              },
              icon: Icon(
                debt.isSettled ? Icons.undo : Icons.check,
              ),
              label: Text(debt.isSettled ? 'Mark as Pending' : 'Mark as Settled'),
            ),
          ],
        ),
      ),
    );
  }
}
