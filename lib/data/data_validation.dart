import 'dart:math';

import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';

import '../models/hive/boxes.dart';
import 'views_data.dart';

// Save budget metrics data
Future updateData(BudgetModel budget, double amount) async {
  double expenseAmount = BudgetViewData().bGamountSpent(budget);
  double percentage;
  List<double> data = List<double>.filled(2, Random().nextDouble());

  expenseAmount = expenseAmount + amount;
  percentage = ((expenseAmount / budget.amount) * 100);

  data[0] = expenseAmount;
  data[1] = percentage;

  Boxes.budgetmate().put(budget.id, data);
}
