import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/data.dart';
import '../../globalwidgtes/disable_list_glow.dart';
import '../../models/budget-models/budgetmodel/budget.dart';
import '../../models/hive/boxes.dart';
import 'homescreen_views/bottomsheets/new_item.dart';
import 'homescreen_views/dialogs/new_expense_dialog/new_expense_dialog.dart';
import 'homescreen_views/dialogs/new_budget_dialog/new_budget_dialog.dart';
import 'homescreen_widgets/budget_tile_widget.dart';
import 'homescreen_widgets/payment_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1
                            //fontFamily: 'OpenSans',
                            ),
                      ),
                      ElevatedButton(
                        onPressed: () => _newItemBS(context),
                        /* onPressed: () async {
                          await Boxes.expenseBox().clear();
                          await Boxes.budgetmate().clear();
                        }, */
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor.withOpacity(0.4),
                            ),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              const CircleBorder(),
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size.fromRadius(20))),
                        child: const Icon(
                          CupertinoIcons.pen,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff929292),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 250,
              child: ValueListenableBuilder(
                  valueListenable: Boxes.budgetBox().listenable(),
                  builder: (context, box, _) {
                    final budgets = box.values.toList().cast<BudgetModel>();
                    print(budgets);
                    return box.isEmpty
                        ? Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: SvgPicture.asset(
                                  'assets/images/empty-budget.svg',
                                  fit: BoxFit.contain,
                                  //height: 250,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SvgPicture.asset(
                                  'assets/images/arrow.svg',
                                  fit: BoxFit.contain,
                                  // height: 250,
                                ),
                              )
                            ],
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
                    'Payment List',
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
              child: SizedBox(
                child: GlowingOverscrollWrapper(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          (MediaQuery.of(context).size.width * (1 / 3)),
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      List titles = categories;
                      List paths = categoriesMap.values.toList().cast<String>();
                      return PaymentTile(
                        title: titles[index],
                        svgPath: paths[index],
                      );
                    },
                  ),
                ),
                /* child: ValueListenableBuilder(
                  valueListenable: Boxes.expenseBox().listenable(),
                  builder: (context, value, child) {
                    final ex = value.values.toList().reversed;
                    final expenses = ex.toList().cast<Expense>();
                    return value.isEmpty
                        ? Center(
                            child: SvgPicture.asset(
                              'assets/images/empty.svg',
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          )
                        : GlowingOverscrollWrapper(
                            child: ListView.builder(
                                itemCount:
                                    expenses.length >= 6 ? 5 : expenses.length,
                                itemBuilder: (context, index) {
                                  return ExpenseTile(
                                    exp: expenses[index],
                                  );
                                }),
                          );
                  },
                ), */
              ),
            )
          ],
        ),
      );
  }

  // Add new Budget Dialog Functions ----------------- //
  Future _addNewBudget(BuildContext cxt) async {
    print('executed at method 1');
    Navigator.of(context).pop();
    await showDialog(
      context: cxt,
      builder: (context) => const NewBudgetDialog(
        budget: null,
      ),
    );
  }
  // ----------------------------------------------- //

  // Add new Budget Dialog Functions ----------------- //
  Future _addNewExpense(BuildContext cxt) async {
    print('executed at method 1');
    Navigator.of(context).pop();
    await showDialog(
      context: cxt,
      builder: (context) => const NewExpenseSD(),
    );
  }
  // ----------------------------------------------- //

  // Add new Item Dialog Functions ----------------- //
  Future _newItemBS(BuildContext cxt) async {
    await showModalBottomSheet(
      /* backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0.0),
          ),
        ),
        context: cxt,
        builder: (context) => const MyWidget() */
      //
      //
      //
      context: cxt,
      builder: (context) => AddNewItemBS(
        newBudget: _addNewBudget,
        newExpense: _addNewExpense,
      ),
    );
  }
  // ----------------------------------------------- //
}
