/// This class cleans up data
/// Either when a budget or spending is deleted
/// It makes sure all data about that items is cleaned up nicely

import 'data.dart';
import '../models/budget-models/budgetmodel/budget.dart';
import '../models/hive/boxes.dart';
import '../models/notification-model/notification.dart';
import 'views_data.dart';

class Clean {
  Clean._internal();
  static final Clean _instance = Clean._internal();
  factory Clean() => _instance;

  // Clean up spendings with given ID
  late List<SpendingModel> _spendings;
  Future cleanSpe(BudgetModel bg) async {
    final spendings = Boxes.spendingBox().values.toList().cast<SpendingModel>();

    _spendings = spendings
        .where((element) => element.ids[0] == bg.id)
        .toList()
        .cast<SpendingModel>();

    for (var element in _spendings) {
      SpendingModel sp = element;
      await sp.delete();
      cleanSpNoti(sp, true);
    }
  }

  // Clean up expenses with given ID
  late List<ExpenseModel> _expenses;
  Future cleanExp(var obj, bool frmBudget) async {
    // first check where the function is being called from
    // if it from delete spending function or edit budget function, delete all expenses related to that spending directly
    // else it was called from delete budget function

    if (frmBudget) {
      BudgetModel bg = obj as BudgetModel;

      final expenses = Boxes.expenseBox().values.toList().cast<ExpenseModel>();

      _expenses = expenses
          .where((element) => element.ids[0] == bg.id)
          .toList()
          .cast<ExpenseModel>();

      for (var element in _expenses) {
        ExpenseModel ex = element;
        await ex.delete();
      }
    } else {
      SpendingModel sp = obj as SpendingModel;
      _getBg(sp);
      cleanBgNoti(_bg);

      List<ExpenseModel> ex;
      //SpendingModel sp = element;

      ex = GetMe.expenses
          .where((element) => element.ids[1] == sp.ids[1])
          .toList()
          .cast<ExpenseModel>();

      if (ex.isEmpty) {
        await sp.delete();
        cleanSpNoti(sp, true);
      } else {
        for (var element in ex) {
          ExpenseModel exp = element;
          exp.delete();
        }
        await sp.delete();
        cleanSpNoti(sp, true);
      }
    }
  }

  // Delete all spending notifications if spent amount is reset below 75%
  Future cleanSpNoti(SpendingModel sp, bool frmSpending) async {
    // first check where the function is being called from
    // if it from delete spending function, delete all notifications related to that spending directly
    // else it was called from delete expense function, check amount spent

    if (frmSpending) {
      final List<NotificationModel> noti = GetMe.notifications
          .where((element) => element.id.contains(sp.ids[1].toString()))
          .toList()
          .cast<NotificationModel>();

      // Delete all noti
      for (var element in noti) {
        await element.delete();
      }
    } else {
      //get total amount currently spent on spendong
      double amountSpent2 = SpendingViewData().sPamountSpent(sp);
// TODO: accommodate full alert and 0.75 notification delection
      if (amountSpent2 < (sp.spendingAmount * 0.75)) {
        final List<NotificationModel> noti = GetMe.notifications
            .where((element) => element.id == '${sp.ids[1]}-75')
            .toList()
            .cast<NotificationModel>();

        // Delete all noti
        for (var element in noti) {
          await element.delete();
        }
      } else if (amountSpent2 >= (sp.spendingAmount * 0.75) &&
          amountSpent2 < sp.spendingAmount) {
        final List<NotificationModel> noti = GetMe.notifications
            .where((element) => element.id == '${sp.ids[1]}-full')
            .toList()
            .cast<NotificationModel>();

        // Delete all noti
        for (var element in noti) {
          await element.delete();
        }
      }
    }
  }

  // Delete all budget notifications if spent amount is reset below 25%
  Future cleanBgNoti(BudgetModel bg) async {
    print("CLEAN NOTI EXEC");
    //get total amount currently spent on budget
    double amountSpent1 = BudgetViewData().bGamountSpent(bg);

    // delete quater notification
    if (amountSpent1 < (bg.amount * 0.25)) {
      final List<NotificationModel> noti = GetMe.notifications
          .where((element) => element.id.contains('${bg.id}'))
          .toList()
          .cast<NotificationModel>();

      // Delete all noti
      for (var element in noti) {
        await element.delete();
      }
    } else if (amountSpent1 < (bg.amount * 0.50)) {
      final List<NotificationModel> n1 = GetMe.notifications
          .where((element) => element.id == "${bg.id}-50")
          .toList()
          .cast<NotificationModel>();

      final List<NotificationModel> n2 = GetMe.notifications
          .where((element) => element.id == "${bg.id}-full")
          .toList()
          .cast<NotificationModel>();

      final List<NotificationModel> noti = [...n1, ...n2];

      // Delete all noti
      for (var element in noti) {
        await element.delete();
      }
    } else if (amountSpent1 >= (bg.amount * 0.5) && amountSpent1 < bg.amount) {
      final List<NotificationModel> noti = GetMe.notifications
          .where((element) => element.id == "${bg.id}-full")
          .toList()
          .cast<NotificationModel>();

      // Delete all noti
      for (var element in noti) {
        await element.delete();
      }
    }
  }

  late BudgetModel _bg;

  BudgetModel _getBg(SpendingModel sp) {
    print('I got smacked');

    _bg = GetMe.budgets
        .where((element) => element.id == sp.ids[0])
        .toList()
        .first;
    return _bg;
  }

  /// CLearing all data------------//

  Future clearAllData() async {
    Boxes.budgetBox().clear();
    Boxes.budgetmate().clear;
    Boxes.expenseBox().clear;
    Boxes.notificationBox().clear;
    Boxes.spendingBox().clear;
  }
}
