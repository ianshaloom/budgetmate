import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../globalwidgtes/expense_tile.dart';
import '../../../../models/hive/boxes.dart';

class BgExpensesPage extends StatelessWidget {
  final controller = TextEditingController();
  BgExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BudgetModel budget =
        ModalRoute.of(context)!.settings.arguments as BudgetModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    '${budget.name} Expenses',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 7,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffD9D9D9),
                  ),
                ),
                Container(
                  height: 55,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff929292))),
                  child: SizedBox(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search Expense',
                        icon: Icon(
                          Icons.search,
                          size: 28,
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                child: ValueListenableBuilder(
                  valueListenable: Boxes.expenseBox().listenable(),
                  builder: (context, value, child) {
                    final ex = value.values.toList().reversed;
                    final expenses = ex
                        .where((element) => element.ids[0] == budget.id)
                        .toList()
                        .cast<ExpenseModel>();
                    return value.isEmpty
                        ? Center(
                            child: SvgPicture.asset(
                              'assets/images/empty.svg',
                              fit: BoxFit.contain,
                              height: 250,
                            ),
                          )
                        : AntiListGlowWrapper(
                            child: ListView.builder(
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  return ExpenseTile(
                                    exp: expenses[index],
                                  );
                                }),
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
