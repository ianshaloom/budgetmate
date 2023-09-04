import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../globalwidgtes/disable_list_glow.dart';
import '../../globalwidgtes/expense_tile.dart';
import '../../models/budget-models/budgetmodel/budget.dart';
import '../../models/hive/boxes.dart';
import '../1homescreen/homescreen_views/3expenseview/expense_dialog_view.dart';
import 'dashboard_views/bottomsheets/new_item.dart';
import '../1homescreen/homescreen_widgets/budget_tile_widget.dart';
import 'dashboard_views/new_budget_dialog/new_budget_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: ValueListenableBuilder(
                    valueListenable: Boxes.budgetBox().listenable(),
                    builder: (context, box, _) {
                      final budgets = box.values.toList().cast<BudgetModel>();
                      return box.isEmpty
                          ? SvgPicture.asset(
                              'assets/images/empty-budget.svg',
                              fit: BoxFit.contain,
                              //height: 250,
                            )
                          : BudgetView(budgets: budgets);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Expenses',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed('/expense_list_page'),
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: ValueListenableBuilder(
                  valueListenable: Boxes.expenseBox().listenable(),
                  builder: (context, value, child) {
                    final ex = value.values.toList().reversed;
                    final expenses = ex.toList().cast<ExpenseModel>();
                    return value.isEmpty
                        ? Center(
                            child: SvgPicture.asset(
                              'assets/images/empty.svg',
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          )
                        : AntiListGlowWrapper(
                            child: ListView.builder(
                                itemCount:
                                    expenses.length >= 6 ? 5 : expenses.length,
                                itemBuilder: (context, index) {
                                  return ExpenseTile(
                                    exp: expenses[index],
                                    onTap: _expenseSD,
                                  );
                                }),
                          );
                  },
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
              backgroundColor:
                  Colors.black /* Theme.of(context).primaryColor */,
              mini: true,
              onPressed: () => _newItemBS(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              /* onPressed: () async {
                              await Boxes.expenseBox().clear();
                              await Boxes.budgetmate().clear();
                            }, */
              child: const Icon(
                Icons.add_rounded,
              )),
        ),
      ],
    );
  }

  // Add new Budget Dialog Functions ----------------- //
  Future _addNewBudget(BuildContext cxt) async {
    Navigator.of(context).pop();
    await showDialog(
      context: cxt,
      builder: (context) => const NewBudgetDialog(
        budget: null,
      ),
    );
  }
  // ----------------------------------------------- //

  // Add new Item Dialog Functions ----------------- //
  Future _newItemBS(BuildContext cxt) async {
    await showModalBottomSheet(
      context: cxt,
      builder: (context) => AddNewBudgetBS(
        newBudget: _addNewBudget
      ),
    );
  }
  // ----------------------------------------------- //

  // Expense Dialod ----------------------------------------------- //
  Future _deleteExpense(ExpenseModel expense) async {
    expense.delete();
    Navigator.of(context).pop();
  }

  Future _expenseSD(BuildContext cxt, ExpenseModel expense) async {
    await showDialog(
      context: cxt,
      builder: (context) => ExpensePageSD(
        expense: expense,
        onPressed: _deleteExpense,
        inDash: true,
      ),
    );
  }
}
