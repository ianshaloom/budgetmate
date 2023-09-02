import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/data.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../data/views_data.dart';

class SpendingTile2 extends StatelessWidget {
  final SpendingModel bsi;

  final ValueNotifier<double> _valueNotifier = ValueNotifier(00);
  final Color color = getcolor();
  SpendingTile2({super.key, required this.bsi});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
            '/budget_detail_page/budget_spending_page',
            arguments: [bsi.ids[1], bsi, color]);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        height: 65,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: bsi.ids[1],
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 60,
                    width: 60,
                    child: DashedCircularProgressBar.aspectRatio(
                      aspectRatio: 1.3, // width ÷ height
                      valueNotifier: _valueNotifier,
                      progress: SpendingViewData().sPamountSpent(bsi),
                      maxProgress: bsi.spendingAmount,
                      corners: StrokeCap.butt,
                      foregroundColor: color,
                      backgroundColor: const Color.fromARGB(45, 105, 105, 105),
                      foregroundStrokeWidth: 5,
                      backgroundStrokeWidth: 5,
                      animation: true,
                      child: Center(
                        child: Text(
                          ExpenseViewData().expenseCount(bsi).toString(),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Text(
                              bsi.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          NumberFormat('#,##0.00')
                              .format(bsi.spendingAmount)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff929292),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Text(
                        '-KSHS. ${NumberFormat('#,##0.00').format(SpendingViewData().sPamountSpent(bsi))}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
