import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/debt_provider.dart';
import 'add_debt_screen.dart';
import 'debt_detail_screen.dart';
import '../models/debt.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debts = ref.watch(debtListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiet Ledger'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddDebtScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: debts.isEmpty
          ? const Center(
        child: Text(
          'No debts yet.\nTap + to add one.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: debts.length,
        itemBuilder: (context, index) {
          Debt debt = debts[index];
          return ListTile(
            title: Text(debt.personName),
            subtitle: Text(
              debt.type == 'money'
                  ? 'Amount: \$${debt.amount?.toStringAsFixed(2) ?? '0.00'}'
                  : 'Item: ${debt.itemName ?? ''}',
            ),
            trailing: Icon(
              debt.isSettled ? Icons.check_circle : Icons.pending,
              color: debt.isSettled ? Colors.green : Colors.orange,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DebtDetailScreen(debt: debt),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
