import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../globalwidgtes/expense_tile.dart';
import '../../../../models/hive/boxes.dart';
import '../3expenseview/expense_dialog_view.dart';

class BgExpensesListPage extends StatefulWidget {
  final List<ExpenseModel> expenses;
  final String name;
  const BgExpensesListPage(
      {super.key, required this.expenses, required this.name});

  @override
  State<BgExpensesListPage> createState() => _BgExpensesListPageState();
}

class _BgExpensesListPageState extends State<BgExpensesListPage> {
  final _controller = TextEditingController();

  List<ExpenseModel> _tempList = [];
  void _searchExpense(String query) {
    List<ExpenseModel> ex = [];

    if (query.isEmpty) {
      ex = widget.expenses;
    } else {
      ex = widget.expenses
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
    _tempList = widget.expenses;
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
        title: Text(
          "${widget.name} Expenses",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
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
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
    widget.expenses.remove(expense);
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
