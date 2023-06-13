import 'package:budgetmate/widgets/expensetile.dart';
import 'package:flutter/material.dart';

import '../database/expense.dart';
import '../widgets/clip_paths.dart';
import '../widgets/twobuttons.dart';

class ExpensePage extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onClear;

  // Expense List
  final List<Expense> expenses = [
    Expense(
      id: 'e1',
      title: 'New Laptop',
      amount: 35000.00,
      date: DateTime.now(),
    ),
    Expense(
      id: 'e1',
      title: 'Account Retry',
      amount: 5000.00,
      date: DateTime.now(),
    ),
    Expense(
      id: 'e1',
      title: 'Semester Fee',
      amount: 25000.00,
      date: DateTime.now(),
    ),
  ];

  ExpensePage({
    super.key,
    required this.onAdd,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              color: Color(0xffffa600),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(40),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    height: 200,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ClipPath(
                    clipper: DrawClip2(),
                    /* child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 60),
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return const ExpenseTile(
                            pageIndex: 0,
                            id: e.id,
                            title: e.title,
                            amount: e.amount,
                            date: e.date,
                          );
                          
                        },
                      ),
                    ), */
                    child: Column(
                      children: expenses.map((e) {
                        return ExpenseTile(
                          pageIndex: 0,
                          id: e.id,
                          title: e.title,
                          amount: e.amount,
                          date: e.date,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: FloatingButtons(
              onAdd: onAdd,
              onClear: onClear,
              pageIndex: 1,
              totalAmount: '15,000',
            ),
          ),
        ],
      ),
    );
  }
}
