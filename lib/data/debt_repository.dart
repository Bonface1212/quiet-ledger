import 'package:hive/hive.dart';
import '../models/debt.dart';

class DebtRepository {
  final Box<Debt> _box = Hive.box<Debt>('debtsBox');

  List<Debt> getAllDebts() {
    return _box.values.toList();
  }

  Future<void> addDebt(Debt debt) async {
    await _box.add(debt);
  }

  Future<void> updateDebt(Debt debt) async {
    await debt.save();
  }

  Future<void> deleteDebt(Debt debt) async {
    await debt.delete();
  }
}
