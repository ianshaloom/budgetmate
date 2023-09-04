import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../data/data.dart';
import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../globalwidgtes/expense_tile.dart';
import '../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../models/hive/boxes.dart';
import '../3expenseview/expense_dialog_view.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  final _controller = TextEditingController();
  final List<ExpenseModel> _expenses = GetMe.expenses;

  List<ExpenseModel> _tempList = [];
  void _searchExpense(String query) {
    List<ExpenseModel> ex = [];

    if (query.isEmpty) {
      ex = _expenses;
    } else {
      ex = _expenses
          .where(
              (e) => e.expenseName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      _tempList = ex;
    });
  }

  @override
  void initState() {
    _tempList = _expenses;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Expenses",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.filter),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: [
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
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xff929292))),
                  child: SizedBox(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search for expense',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        icon: Icon(
                          Icons.search,
                          size: 28,
                        ),
                      ),
                      onChanged: (value) => _searchExpense(value),
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
                              itemCount: _tempList.length,
                              itemBuilder: (context, index) {
                                return ExpenseTile(
                                  exp: _tempList[index],
                                  onTap: _expenseSD,
                                );
                              },
                            ),
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

  // Expense Dialod ----------------------------------------------- //
  Future _deleteExpense(ExpenseModel expense) async {
    _tempList.remove(expense);
    _expenses.remove(expense);
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
