import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/chartslideshow.dart';
import '../widgets/expensetile.dart';
import '../database/expense.dart';
import '../widgets/clip_paths.dart';

class ExpensePage extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onClear;
  final Function deleteExpense;
  final List<Expense> expenses;
  final List<Expense> recentExpences;

  const ExpensePage({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.deleteExpense,
    required this.expenses,
    required this.recentExpences,
  });

  void delete(int index) {
    deleteExpense(index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          //color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(75.0),
          ),
        ),
        child: expenses.isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    margin: const EdgeInsets.only(
                        bottom: 10, top: 10, left: 5, right: 5),
                    height: 200,
                    decoration: const BoxDecoration(
                      //color: Color.fromARGB(158, 255, 0, 0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: Chartslideshow(
                      recentExpences: recentExpences,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ClipPath(
                      clipper: DrawClip2(),
                      child: ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) => ExpenseTile(
                          title: expenses[index].title,
                          amount: expenses[index].amount,
                          date: expenses[index].date,
                          delete: (context) => delete(index),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _noData(context),
      ),
    );
  }

  Widget _noData(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/data.svg',
                width: double.infinity, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 30),
                      child: Text(
                        'No expenses added yet!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/arrow.svg',
                      height: 120,
                    ),
                  ],
                ),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/data.svg',
                width: double.infinity, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 20),
                      child: Text(
                        'No expenses added yet!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/arrow.svg',
                      height: 120,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
