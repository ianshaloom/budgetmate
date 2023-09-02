import 'package:budgetmate/data/data_validation.dart';
import 'package:budgetmate/models/hive/boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../globalwidgtes/clip_paths.dart';

class BudgetView extends StatelessWidget {
  final List budgets;
  final pageController = PageController(viewportFraction: 0.9);
  BudgetView({super.key, required this.budgets});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DrawClip2(),
      child: PageView.builder(
        controller: pageController,
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          updateData(budgets[index], 0);
          return budgetTile(context, index);
        },
      ),
      /* child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: budgets.length,
        itemBuilder: (context, index) => budgetTile(context, index),
      ), */
    );
  }

  Widget budgetTile(BuildContext context, int index) {
    /* double percent() {
      double percent;
      double i = budgets[index].amount;

      percent = (BudgetViewData().bGamountSpent(budgets[index]) / i) * 100;

      return percent;
    } */

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
          height: 240,
          //padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(3),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: const Color(0xff000000),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 148,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          'Your available budget amount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'KES ${NumberFormat('#,##0.00').format(budgets[index].amount)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ValueListenableBuilder(
                          valueListenable: Boxes.budgetmate().listenable(),
                          builder: (context, value, child) {
                            final List<double> data =
                                value.get(budgets[index].id) ?? [0, 0];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'KES ${NumberFormat('#,##0.00').format(data[0])}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_up_rounded,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        '${data[1].toStringAsFixed(1)} %',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            budgets[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Date Added: ${DateFormat.yMMMd().format(budgets[index].date)}',
                              style: const TextStyle(
                                color: Color(0xff939191),
                                fontFamily: 'Hubballi',
                                fontSize: 13,
                                letterSpacing: 1.5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          IconButton.filled(
                            onPressed: () => Navigator.of(context).pushNamed(
                                '/budget_detail_page',
                                arguments: budgets[index]),
                            icon: const Icon(
                              Icons.arrow_outward_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Open',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
