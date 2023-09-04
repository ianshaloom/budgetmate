import 'package:budgetmate/data/data.dart';
import 'package:budgetmate/data/views_data.dart';
import 'package:budgetmate/models/budget-models/budgetmodel/budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ExpensePageSD extends StatelessWidget {
  final ExpenseModel expense;
  final Function onPressed;
  final bool inDash;

  ExpensePageSD(
      {super.key,
      required this.expense,
      required this.onPressed,
      required this.inDash});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: inDash ? 190 : 225,
      ),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.xmark),
                ),
              ),
            ),
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                expense.category,
                fit: BoxFit.cover,
                height: 110,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              expense.expenseName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${DateFormat.d().format(expense.date)} ${DateFormat.MMM().format(expense.date)} ${DateFormat.y().format(expense.date)}   •  ${formatter.format(DateTime.now())}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff929292),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            inDash
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xffDFDFDF),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Budget",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff929292),
                              ),
                            ),
                            Text(
                              BudgetViewData().getBudgetName(expense.ids[0]),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Spending",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff929292),
                              ),
                            ),
                            Text(
                              SpendingViewData()
                                  .getSpendingName(expense.ids[1]),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(),
            Container(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 8),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xffDFDFDF),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff929292),
                        ),
                      ),
                      Text(
                        _getCategory(expense.category),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff929292),
                        ),
                      ),
                      Text(
                        '- KES. ${expense.amountSpent}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffF22E2E)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: const Color(0xffC10000),
              onPressed: () => onPressed(expense),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              label: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              icon: const Icon(CupertinoIcons.delete),
            ),
          ],
        ),
      ),
    );
  }

  final DateFormat formatter = DateFormat('HH:mm');

  String _getCategory(String cat) {
    String category = '';

    categoriesMap.forEach((key, value) {
      if (cat == value) {
        category = key;
      }
    });

    return category;
  }
}
