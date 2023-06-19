import 'package:budgetmate/widgets/budget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../database/budget.dart';
import '../widgets/clip_paths.dart';

class BudgetPage extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onClear;
  final List<Budget> budgets;
  const BudgetPage({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.budgets,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 2),
      child: budgets.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Text(
                      'No budgets added yet!',
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
          : Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                //color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    child: SvgPicture.asset(
                      'assets/images/budget.svg',
                      height: 100,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ClipPath(
                      clipper: DrawClip2(),
                      child: ListView.builder(
                        itemCount: budgets.length,
                        itemBuilder: (context, index) => BudgetTile(
                          title: budgets[index].title,
                          amount: budgets[index].amount,
                          date: budgets[index].date,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
