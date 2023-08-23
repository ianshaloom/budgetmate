import 'package:hive/hive.dart';

import '../budget-models/budgetmodel/budget.dart';

class Boxes {
  static Box<BudgetModel> budgetBox() => Hive.box<BudgetModel>('budget');
  static Box<Spending> spendingBox() => Hive.box<Spending>('spending');
  static Box<Expense> expenseBox() => Hive.box<Expense>('expense');
  static Box budgetmate() => Hive.box('budgetmate');
}
