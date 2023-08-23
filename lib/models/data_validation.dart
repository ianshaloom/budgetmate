import 'dart:math';

import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';

import 'hive/boxes.dart';
import 'views_data.dart';

late List<Spending> _spendings;
Future deleteSpendings(int id) async {
  final spendings = Boxes.spendingBox().values.toList().cast<Spending>();

  _spendings = spendings
      .where((element) => element.ids[0] == id)
      .toList()
      .cast<Spending>();

  for (var element in _spendings) {
    Spending sp = element;
    sp.delete();
  }
}

late List<Expense> _expenses;
Future deleteExpenses(int id) async {
  final expenses = Boxes.expenseBox().values.toList().cast<Expense>();

  _expenses = expenses
      .where((element) => element.ids[0] == id)
      .toList()
      .cast<Expense>();

  for (var element in _expenses) {
    Expense ex = element;
    ex.delete();
  }
}



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



class GetMe {
  
    // Get all Objects to a List
  static List<BudgetModel> get budgets =>
      Boxes.budgetBox().values.toList().cast<BudgetModel>();
      
  static List<Spending> get spendings =>
      Boxes.spendingBox().values.toList().cast<Spending>();
      
  static List<Expense> get expenses =>
      Boxes.expenseBox().values.toList().cast<Expense>();
  
  /* static List<Expense> get expenses =>
      Boxes.expenseBox().values.toList().cast<Expense>(); */
  
}
