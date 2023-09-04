import 'package:flutter/material.dart';

import '../views/1homescreen/homescreen_views/1budgetview/budget_detail.dart';
import '../views/1homescreen/homescreen_views/expenseview/expenses_list_view.dart';
import '../views/1homescreen/homescreen_views/payment-list-view/payment_list_page.dart';
import '../views/1homescreen/homescreen_views/2spendingview/spending_detailed_page.dart';
import '../views/mainpage/mainpage.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const MainPage(),
  '/expense_list_page': (context) => const ExpensesListPage(),
  '/budget_detail_page': (context) => const BudgetDetailedPage(),
  '/budget_detail_page/budget_spending_page': (context) =>
      SpendingDetailedPage(),
  '/home_page/paymentlist_page/': (context) => const PaymentListPage(),
};
