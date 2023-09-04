import 'package:budgetmate/views/1homescreen/homescreen_views/expenseview/budget_expenses_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../data/data.dart';
import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../data/clean_up.dart';
import '../../../../models/hive/boxes.dart';
import '../../../../data/views_data.dart';
import 'widgets/delete_budget.dart';
import 'dialogs/add_spending_dialog.dart';
import 'dialogs/edit_budget_dialog.dart';
import 'widgets/spending_tile2.dart';

class BudgetDetailedPage extends StatefulWidget {
  const BudgetDetailedPage({super.key});

  @override
  State<BudgetDetailedPage> createState() => _BudgetDetailedPageState();
}

class _BudgetDetailedPageState extends State<BudgetDetailedPage> {
  List<SpendingModel> _spendings =
      GetMe.spendings.toList().cast<SpendingModel>();
  final Clean _clean = Clean();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final budget = ModalRoute.of(context)!.settings.arguments as BudgetModel;

    _spendings = _spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<SpendingModel>();

    final ex = GetMe.expenses.toList().reversed;
    List<ExpenseModel> expenses = ex
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<ExpenseModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: ValueListenableBuilder(
          //----------------------------------------- ValueListenableBuilder
          valueListenable: Boxes.budgetBox().listenable(),
          builder: (context, box, _) {
            return Text(
              budget.name,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.insights_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            //height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Budget Amount',
                  style: TextStyle(
                    color: const Color(0xffFFFFFF).withOpacity(0.7),
                    fontSize: 14,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'KES',
                        style: TextStyle(
                          fontSize: 17,
                          color: const Color(0xffFFFFFF).withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      //------------------------------------------------------------------------------------------- ValueListenableBuilder
                      valueListenable: Boxes.budgetBox().listenable(),
                      builder: (context, box, _) {
                        return Text(
                          NumberFormat('#,##0.00').format(budget.amount),
                          style: const TextStyle(
                            fontSize: 40,
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'OpenSans',
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  width: size.width * 0.75,
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white24.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //
                  //
                  child: ValueListenableBuilder(
                    //---------------------------------------------------------------------------------------------- ValueListenableBuilder
                    valueListenable: Boxes.budgetmate().listenable(),
                    builder: (context, box, _) {
                      double totalSpent =
                          BudgetViewData().bGamountSpent(budget);
                      double budgetBalance = budget.amount - totalSpent;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                NumberFormat('#,##0.00').format(totalSpent),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Total Spent',
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                NumberFormat('#,##0.00').format(budgetBalance),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Budget Balance',
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Date Added: ${DateFormat.yMMMd().format(budget.date)}',
                    style: const TextStyle(
                      color: Color(0xff939191),
                      fontFamily: 'Hubballi',
                      fontSize: 13,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              _newSpendingItemSD(context, budget.id),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                const CircleBorder(),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size.fromRadius(25))),
                          child: SvgPicture.asset(
                            'assets/images/add.svg',
                            fit: BoxFit.contain,
                            height: 25,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _editBudgetSD(context, budget),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                const CircleBorder(),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size.fromRadius(25))),
                          child: SvgPicture.asset(
                            'assets/images/edit.svg',
                            fit: BoxFit.contain,
                            height: 25,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _deleteBudgetBS(context, budget),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                const CircleBorder(),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size.fromRadius(25))),
                          child: SvgPicture.asset(
                            'assets/images/delete.svg',
                            fit: BoxFit.contain,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Spending Items',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                          ..push(MaterialPageRoute(
                            builder: (context) => BgExpensesListPage(
                                expenses: expenses, name: budget.name),
                          )),
                        child: Text(
                          'Expenses',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Spendings List
                  Flexible(
                    fit: FlexFit.loose,
                    child: ValueListenableBuilder(
                      //----------------------------------------- ValueListenableBuilder
                      valueListenable: Boxes.spendingBox().listenable(),
                      builder: (context, box, _) {
                        // reversed list of spendings
                        var sp = box.values.toList().reversed;
                        // new list with matchind sp and bg IDS
                        List<SpendingModel> spendings = sp
                            .where((element) => element.ids[0] == budget.id)
                            .toList()
                            .cast<SpendingModel>();

                        // return List
                        return spendings.isEmpty
                            ? Center(
                                child: SvgPicture.asset(
                                  'assets/images/add.svg',
                                  fit: BoxFit.contain,
                                  height: 60,
                                ),
                              )
                            : AntiListGlowWrapper(
                                child: ListView.builder(
                                  itemCount: spendings.length,
                                  itemBuilder: (context, index) {
                                    return SpendingTile2(bsi: spendings[index]);
                                  },
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Delete Budget BottomSheet
  Future _deleteBudgetBS(BuildContext cxt, BudgetModel budget) async {
    await showModalBottomSheet(
      context: cxt,
      builder: (context) => DeleteBudgetBS(
        onPressed: _deleteBudget,
        budget: budget,
      ),
    );
  }

  Future _deleteBudget(BudgetModel budget) async {
    budget.delete();

    // clean budget notifications
    _clean.cleanBgNoti(budget);

    // clean budget spending notifications ------------- //
    final spendings = GetMe.spendings;
    _spendings = spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<SpendingModel>();

    for (var element in _spendings) {
      SpendingModel sp = element;
      _clean.cleanSpNoti(sp, true);
    }
    // ------------------------------------------------- //

    //clean budget spendings
    _clean.cleanSpe(budget);

    // clean budget expenses
    _clean.cleanExp(budget, true);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // Edit Budget Dialog
  Future _editBudgetSD(BuildContext cxt, BudgetModel budget) async {
    await showDialog(
      context: cxt,
      builder: (context) => EditBudgetSD(budget: budget),
    );
  }

  // Add Spending Item Dialog
  Future _newSpendingItemSD(BuildContext cxt, int id) async {
    await showDialog(
      context: cxt,
      builder: (context) => NewSpendingSD(
        budgetID: id,
      ),
    );
  }

  // Spending state fuctions ----------------------------------------- //

  // Delete Budget BottomSheet
  Future _deleteSpendingBS(BuildContext cxt, BudgetModel budget) async {
    await showModalBottomSheet(
      context: cxt,
      builder: (context) => DeleteBudgetBS(
        onPressed: _deleteSpending,
        budget: budget,
      ),
    );
  }

  Future _deleteSpending(BudgetModel budget) async {
    budget.delete();

    // clean budget notifications
    _clean.cleanBgNoti(budget);

    // clean budget spending notifications ------------- //
    final spendings = GetMe.spendings;
    _spendings = spendings
        .where((element) => element.ids[0] == budget.id)
        .toList()
        .cast<SpendingModel>();

    for (var element in _spendings) {
      SpendingModel sp = element;
      _clean.cleanSpNoti(sp, true);
    }
    // ------------------------------------------------- //

    //clean budget spendings
    _clean.cleanSpe(budget);

    // clean budget expenses
    _clean.cleanExp(budget, true);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
