import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../database/expense.dart';
import 'bottomsheetpage.dart';
import 'budgetpage.dart';
import 'expensepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // Expense List
  List<Expense> expenses = [
    Expense(
      id: 'e1',
      title: 'New Laptop',
      amount: 35000.00,
      date: DateTime.now(),
    )
  ];
  
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
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: _pageIndex == 0
          ? const Color.fromARGB(75, 255, 166, 0)
          : const Color.fromARGB(73, 170, 189, 248),
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
        side: BorderSide(
          color: _pageIndex == 0
              ? const Color(0xffffa600)
              : const Color(0xffaabdf8),
        ),
      ),
      context: context,
      builder: (BuildContext context) => const BottomSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _pageIndex == 0 ? const Color(0xffffa600) : const Color(0xffaabdf8),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          _pageIndex == 0 ? "Expenses Summary" : "Mothly Budget",
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView(
              controller: _pageController,
              onPageChanged: ((value) => _setPageIndex(value)),
              children: [
                ExpensePage(
                  onAdd: () => _showBottomSheet(context),
                  onClear: () => _showBottomSheet(context),
                ),
                BudgetPage(
                  onAdd: () => _showBottomSheet(context),
                  onClear: () => _showBottomSheet(context),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  dotWidth: 20,
                  activeDotColor: _pageIndex == 0
                      ? const Color(0xffffa600)
                      : const Color(0xffaabdf8),
                  dotColor: _pageIndex == 0
                      ? const Color(0xffaabdf8)
                      : const Color(0xffffa600),
                  spacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/*     Future _confirmClear() async {
    switch (await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Your Habits Tracker'),
            content: const Text('Are you sure you want to Clear Your Habits?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'Yes');
                },
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: const Text('No'),
              ),
            ],
          );
        })) {
      case 'Yes':
        setState(() {
          a.habits.clear();
        });
        a.updateCurrentDb();
        break;
      case 'No':
        break;
    }
  } */
}
