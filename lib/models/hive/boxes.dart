import 'package:hive/hive.dart';

import '../budget-models/budgetmodel/budget.dart';
import '../notification-model/notification.dart';

class Boxes {
  static Box<BudgetModel> budgetBox() => Hive.box<BudgetModel>('budget');

  static Box<SpendingModel> spendingBox() =>
      Hive.box<SpendingModel>('spending');

  static Box<ExpenseModel> expenseBox() => Hive.box<ExpenseModel>('expense');

  static Box<NotificationModel> notificationBox() =>
      Hive.box<NotificationModel>('notification');

  static Box budgetmate() => Hive.box('budgetmate');
}
