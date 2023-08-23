import 'dart:math';

import 'package:hive/hive.dart';

part 'budget.g.dart';

// Get Random ID
int getRandom() {
  int i;
  i = Random().nextInt(999999) + 100001;
  return i;
}

@HiveType(typeId: 0)
class BudgetModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  int id;

  BudgetModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
  });
}

@HiveType(typeId: 1)
class Spending extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double spendingAmount;

  @HiveField(2)
  double? spentAmount;

  @HiveField(3)
  List<int> ids = List<int>.filled(2, getRandom());

  Spending({
    required this.ids,
    required this.name,
    required this.spendingAmount,
    required this.spentAmount,
  });
}

@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  String expenseName;

  @HiveField(2)
  double amountSpent;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  List<int> ids = List<int>.filled(3, getRandom());

  Expense({
    required this.ids,
    required this.category,
    required this.expenseName,
    required this.amountSpent,
    required this.date,
  });
}