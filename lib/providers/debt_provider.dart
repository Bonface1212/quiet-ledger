import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/debt_repository.dart';
import '../models/debt.dart';

final debtRepositoryProvider = Provider<DebtRepository>((ref) {
  return DebtRepository();
});

final debtListProvider = StateNotifierProvider<DebtListNotifier, List<Debt>>((ref) {
  final repo = ref.watch(debtRepositoryProvider);
  return DebtListNotifier(repo);
});

class DebtListNotifier extends StateNotifier<List<Debt>> {
  final DebtRepository _repo;

  DebtListNotifier(this._repo) : super(_repo.getAllDebts());

  void addDebt(Debt debt) {
    _repo.addDebt(debt);
    state = _repo.getAllDebts();
  }

  void updateDebt(Debt debt) {
    _repo.updateDebt(debt);
    state = _repo.getAllDebts();
  }

  void deleteDebt(Debt debt) {
    _repo.deleteDebt(debt);
    state = _repo.getAllDebts();
  }
}
