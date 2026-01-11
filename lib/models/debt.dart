import 'package:hive/hive.dart';

part 'debt.g.dart'; // Needed for code generation

@HiveType(typeId: 0)
class Debt extends HiveObject {
  @HiveField(0)
  String personName;

  @HiveField(1)
  String type; // 'money' or 'item'

  @HiveField(2)
  double? amount;

  @HiveField(3)
  String? itemName;

  @HiveField(4)
  DateTime dateLent;

  @HiveField(5)
  bool isSettled;

  @HiveField(6)
  DateTime? lastReminderDate;

  @HiveField(7)
  String? notes;

  Debt({
    required this.personName,
    required this.type,
    this.amount,
    this.itemName,
    required this.dateLent,
    this.isSettled = false,
    this.lastReminderDate,
    this.notes,
  });
}
