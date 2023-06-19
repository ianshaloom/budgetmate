import 'package:flutter/material.dart';

import '../database/budget.dart';
import '../database/expense.dart';
import '../widgets/floating_shortcuts.dart';
import 'bottomsheetpage.dart';
import 'budgetpage.dart';
import 'expensepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // page index and contoller
  late int _pageIndex = 0;
  final _pageController = PageController();

  // set page new index onchanged
  void _setPageIndex(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  // draw bottom sheet
  void _expenceForm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => BottomSheetContent(
        pageIndex: _pageIndex,
        addExpense: _addNewExpense,
        addBudget: _addNewBudget,
      ),
    );
  }

  // Adding a new Expense
  void _addNewExpense(String exTitle, double exAmount, DateTime selectedDate) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: exTitle,
      amount: exAmount,
      date: selectedDate,
    );

    setState(() {
      _expenses.add(newExpense);
    });
  }

  // Adding a new Budget
  void _addNewBudget(String bgTitle, double bgAmount, DateTime selectedDate) {
    final newBudget = Budget(
      id: DateTime.now().toString(),
      title: bgTitle,
      amount: bgAmount,
      date: selectedDate,
    );

    setState(() {
      _budget.add(newBudget);
    });
  }

  // delete expense
  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  // Getter for recent expences
  List<Expense> get _recentExpences {
    return _expenses.where((e) {
      return e.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        /* title: Text(
          _pageIndex == 0 ? "Expenses Summary" : "Mothly Budget",
        ), */
        toolbarHeight: 10,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 0,
                child: _pageIndex == 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              "Expenses",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0),
                            ),
                            Text(
                              ' Summary',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              "Monthy",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0),
                            ),
                            Text(
                              ' Budget',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                    ),
                  ),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: ((value) => _setPageIndex(value)),
                    children: [
                      ExpensePage(
                        onAdd: () => _expenceForm(context),
                        onClear: () => _expenceForm(context),
                        deleteExpense: _deleteExpense,
                        expenses: _expenses,
                        recentExpences: _recentExpences,
                      ),
                      BudgetPage(
                        onAdd: () => _expenceForm(context),
                        onClear: () => _expenceForm(context),
                        budgets: _budget,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: _buildButtonHolder(context),
          ),
        ],
      ),
    );
  }

// floating button holder
  Widget _buildButtonHolder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 130,
          decoration: const BoxDecoration(
            color: Color.fromARGB(88, 44, 49, 64),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: _pageIndex == 0
              ? ExpenseFloatingButtons(
                  onAdd: () => _expenceForm(context),
                  onClear: () {
                    setState(() {
                      _expenses.clear();
                    });
                  },
                  pageIndex: 0,
                  totalAmount: '18,000',
                )
              : BudgetFloatButtons(
                  onAdd: () => _expenceForm(context),
                  onClear: () {
                    setState(() {
                      _budget.clear();
                    });
                  },
                  pageIndex: 1,
                  totalAmount: '10,000',
                ),
        ),
      ],
    );
  }

// Expense List
  final List<Expense> _expenses = [
    Expense(
      id: 'e1',
      title: 'Food and Beverage',
      amount: 5000.00,
      date: DateTime.now(),
    ),
    Expense(
      id: 'e1',
      title: 'Shopping',
      amount: 1800.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: 'e1',
      title: 'Family and Friends',
      amount: 7000.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 4',
      amount: 9000.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 3',
      amount: 1200.00,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 2',
      amount: 2000.00,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 1',
      amount: 6000.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 8',
      amount: 3000.00,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Expense(
      id: 'e1',
      title: 'Test 7',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];

  // Budget List
  final List<Budget> _budget = [
    Budget(
      id: 'e1',
      title: 'Buy New Laptop',
      amount: 35.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Rent',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Car Wash',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Buy New Hardisk',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Monthly Shopping',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Custom Sneakers',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Laptop Repair',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Budget(
      id: 'e1',
      title: 'Savings Account',
      amount: 35000.00,
      date: DateTime.now(),
    ),
  ];
}
