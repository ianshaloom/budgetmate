import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';
import 'package:flutter/material.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../globalwidgtes/expense_tile.dart';
import '../../../../models/data_validation.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  final _controller = TextEditingController();
  final List<Expense> _expenses = GetMe.expenses;

  List<Expense> _tempList = [];
  void _searchExpense(String query) {
    List<Expense> ex = [];

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
                  child: const Text(
                    'All Expenses',
                    style: TextStyle(
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
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context).textTheme.bodyMedium,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search Expense',
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
                child: GlowingOverscrollWrapper(
                  child: ListView.builder(
                    itemCount: _tempList.length,
                    itemBuilder: (context, index) {
                      return ExpenseTile(
                        exp: _tempList[index],
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
