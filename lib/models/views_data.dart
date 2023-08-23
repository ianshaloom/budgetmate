import 'budget-models/budgetmodel/budget.dart';
import 'hive/boxes.dart';

List<Expense> get _expenses =>
    Boxes.expenseBox().values.toList().cast<Expense>();

class BudgetViewData {
  // Calculate the amount of money spent on expenses in a budget
  double bGamountSpent(BudgetModel budget) {
    double amount = 0;
    List<Expense> expenses = _expenses
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<Expense>();

    if (expenses.isEmpty) {
      amount = 0.0;
    } else {
      for (var e in expenses) {
        amount = amount + e.amountSpent;
      }
    }

    return amount;
  }
}

class SpendingViewData {
  // Calculate the amount of money spent on expenses in a budget
  double sPamountSpent(Spending spending) {
    double amount = 0;
    List<Expense> expenses = _expenses
        .where((element) => element.ids[1] == spending.ids[1])
        .toList()
        .cast<Expense>();

    if (expenses.isEmpty) {
      amount = 0.0;
    } else {
      for (var e in expenses) {
        amount = amount + e.amountSpent;
      }
    }

    return amount;
  }
}

class ExpenseViewData {
  ExpenseViewData._internal();
  static final ExpenseViewData _instance = ExpenseViewData._internal();
  factory ExpenseViewData() => _instance;

  // Calculate the amount of money spent on expenses in a budget
  int expenseCount(Spending spending) {
    int count = 0;
    List<Expense> expenses = _expenses
        .where((element) => element.ids[1] == spending.ids[1])
        .toList()
        .cast<Expense>();

    expenses.isEmpty ? count = 0 : count = expenses.length;

    return count;
  }
}

/// This a Temporary Data Processing and Storage Model Class ------------------- ///
class ViewData {
  ViewData._internal();
  static final ViewData _instance = ViewData._internal();

  factory ViewData() {
    return _instance;
  }

  // Temporary save Spending Items before saving the whole budget in Database
  /* Used in new_budget and new_spending files */
  static List temporarySpendings = <Spending>[];
  // -----------------------------------------------------------------------//

  // Get all Objects to a List
  static List<BudgetModel> budgets =
      Boxes.budgetBox().values.toList().cast<BudgetModel>();
  static List<Spending> spendings =
      Boxes.spendingBox().values.toList().cast<Spending>();
  static List<Expense> expenses =
      Boxes.expenseBox().values.toList().cast<Expense>();

  //
  //
  //
  //
  //
  // Handle BudgetModel
  static List<String> budgetNames = [];

  // Fill the abouve two lists
  void getBudgetsNames() {
    budgets = Boxes.budgetBox().values.toList().cast<BudgetModel>();

    if (budgets.isNotEmpty) {
      for (BudgetModel element in budgets) {
        String name = element.name;
        // store name
        budgetNames.add(name);
      }
    }
  }

  //
  //
  //
  //
  // Handle BudgetSpending
  static List<String> spendingNames = [];

  // Fill the abouve two lists
  void getSpendingNames(BudgetModel budget) {
    spendings = Boxes.spendingBox().values.toList().cast<Spending>();

    spendings = spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<Spending>();

    if (spendings.isNotEmpty) {
      for (Spending element in spendings) {
        String name = element.name;
        // store name
        spendingNames.add(name);
      }
    }
  }
}
