import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/quiet_ledger_app.dart';
import 'models/debt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(DebtAdapter());

  // Open a box for debts
  await Hive.openBox<Debt>('debtsBox');

  runApp(const ProviderScope(child: QuietLedgerApp()));
}
