import 'data.dart';
import '../models/budget-models/budgetmodel/budget.dart';
import 'data_validation.dart';
import '../models/hive/boxes.dart';
import '../models/notification-model/notification.dart';

List<ExpenseModel> get _expenses =>
    Boxes.expenseBox().values.toList().cast<ExpenseModel>();

class BudgetViewData {
  // Calculate the amount of money spent on expenses in a budget
  double bGamountSpent(BudgetModel budget) {
    double amount = 0;
    List<ExpenseModel> expenses = _expenses
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<ExpenseModel>();

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
  // Calculate the amount of money spent on expenses in a spending
  double sPamountSpent(SpendingModel spending) {
    double amount = 0;
    List<ExpenseModel> expenses = _expenses
        .where((element) => element.ids[1] == spending.ids[1])
        .toList()
        .cast<ExpenseModel>();

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
  int expenseCount(SpendingModel spending) {
    int count = 0;
    List<ExpenseModel> expenses = _expenses
        .where((element) => element.ids[1] == spending.ids[1])
        .toList()
        .cast<ExpenseModel>();

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
  static List temporarySpendings = <SpendingModel>[];
  // -----------------------------------------------------------------------//

  // Get all Objects to a List
  static List<BudgetModel> budgets =
      Boxes.budgetBox().values.toList().cast<BudgetModel>();
  static List<SpendingModel> spendings =
      Boxes.spendingBox().values.toList().cast<SpendingModel>();
  static List<ExpenseModel> expenses =
      Boxes.expenseBox().values.toList().cast<ExpenseModel>();

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
    spendings = Boxes.spendingBox().values.toList().cast<SpendingModel>();

    spendings = spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<SpendingModel>();

    if (spendings.isNotEmpty) {
      for (SpendingModel element in spendings) {
        String name = element.name;
        // store name
        spendingNames.add(name);
      }
    }
  }
}

class NotiViewData {
  NotiViewData._internal();
  static final NotiViewData _instance = NotiViewData._internal();
  factory NotiViewData() => _instance;

  //
  // ---------------------------- Budget Notification -------------------------- //
  Future budgetNoti(BudgetModel budget) async {
    print('BUDGET NOTIFICATION EXECUTED');
    String notification;

    //get total amount currently spent
    double amountSpent = BudgetViewData().bGamountSpent(budget);
    print('$amountSpent aaaiiiiiiiiiiiiiiiiiii');

    bool quater = (amountSpent >= (budget.amount * 0.25) &&
            amountSpent < (budget.amount * 0.5))
        ? true
        : false;

    bool half =
        (amountSpent >= (budget.amount * 0.50) && amountSpent < (budget.amount))
            ? true
            : false;

    bool full = (amountSpent == budget.amount) ? true : false;

    bool exceed = (amountSpent > budget.amount) ? true : false;

    if (quater && isNew('${budget.id}-25')) {
      print('QUATERS');
      notification = budgteAlertContent(budget.name, 0);
      final NotificationModel n;
      n = NotificationModel(
        title: _bgAlerts[0][0],
        content: notification,
        date: DateTime.now(),
        color: _bgAlerts[0][1],
        id: '${budget.id}-25',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    } else if (half && isNew('${budget.id}-50')) {
      notification = budgteAlertContent(budget.name, 1);

      final NotificationModel n;
      n = NotificationModel(
        title: _bgAlerts[0][0],
        content: notification,
        date: DateTime.now(),
        color: _bgAlerts[0][1],
        id: '${budget.id}-50',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    } else if (full && isNew('${budget.id}-full')) {
      notification = budgteAlertContent(budget.name, 2);

      final NotificationModel n;
      n = NotificationModel(
        title: _bgAlerts[1][0],
        content: notification,
        date: DateTime.now(),
        color: _bgAlerts[1][1],
        id: '${budget.id}-full',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    } else if (exceed && isNew('${budget.id}-exceed')) {
      notification = budgteAlertContent(budget.name, 3);

      final NotificationModel n;
      n = NotificationModel(
        title: _bgAlerts[2][0],
        content: notification,
        date: DateTime.now(),
        color: _bgAlerts[2][1],
        id: '${budget.id}-exceed',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    }
  }

  //Check if the notification is already in our database
  bool isNew(String id) {
    final List<NotificationModel> noti = GetMe.notifications
        .where((element) => element.id == id)
        .toList()
        .cast<NotificationModel>();

    return noti.isEmpty ? true : false;
  }

  // Budget Notification title and color
  final List _bgAlerts = [
    ['Update on your budget amount', '#33CCEE'],
    ["Congrats, You've Reached Your Budget", '#22BB55'],
    ["Budget Alert: Exceeded Budget", '#EE4444'],
  ];

  // Budget Notification content
  String budgteAlertContent(String budgetName, int id) {
    if (id == 0) {
      return 'Update on $budgetName. Currently, a quarter (25%) or more of your allocated budget has been utilized. Keep an eye on your spending to ensure you stay within your budget goals.';
    } else if (id == 1) {
      return 'Update on $budgetName. Currently, a half (50%) or more of your allocated budget has been utilized. Keep an eye on your spending to ensure you stay within your budget goals.';
    } else if (id == 2) {
      return "Congratulations on $budgetName. You've successfully managed your spending and utilized your budgeted amount to its fullest. Your diligence and financial planning have paid off! ";
    } else {
      return "Alert on $budgetName. Your spending has exceeded the budgeted amount. It's important to review your expenses and consider making adjustments to get back on track with your budget goals. ";
    }
  }

  //
  // ---------------------------- Spending Notification -------------------------- //
  Future spendNoti(SpendingModel spending) async {
    print('Spending NOTIFICATION EXECUTED');
    String notification;

    //get total amount currently spent
    double amountSpent = SpendingViewData().sPamountSpent(spending);

    bool quater = (amountSpent >= (spending.spendingAmount * 0.75) &&
            amountSpent < spending.spendingAmount)
        ? true
        : false;

    bool full = (amountSpent == spending.spendingAmount) ? true : false;

    if (quater && isNew('${spending.ids[1]}-25')) {
      notification = spendAlertContent(spending.name, 0);
      final NotificationModel n;
      n = NotificationModel(
        title: _spAlerts[0][0],
        content: notification,
        date: DateTime.now(),
        color: _spAlerts[0][1],
        id: '${spending.ids[1]}-25',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    } else if (full && isNew('${spending.ids[1]}-full')) {
      notification = spendAlertContent(spending.name, 1);

      final NotificationModel n;
      n = NotificationModel(
        title: _spAlerts[1][0],
        content: notification,
        date: DateTime.now(),
        color: _spAlerts[1][1],
        id: '${spending.ids[1]}-full',
      );

      // add notification to database
      await Boxes.notificationBox().add(n);
    }
  }

  // Budget Notification title and color
  final List _spAlerts = [
    ['Update on your spending amount', '#33CCEE'],
    ["Hurray, Spending completed", '#22BB55'],
  ];

  // Budget Notification content
  String spendAlertContent(String spendName, int id) {
    if (id == 0) {
      return 'Update on $spendName. Currently, three quarters (75%) or more of your allocated spending has been utilized. Keep an eye on your spending to ensure you stay within your spending goals.';
    } else {
      return "Congratulations on $spendName. You've successfully managed your spending and utilized your spending amount to its fullest.";
    }
  }
}
