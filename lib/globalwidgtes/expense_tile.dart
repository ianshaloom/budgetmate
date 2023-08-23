import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/budget-models/budgetmodel/budget.dart';

class ExpenseTile extends StatelessWidget {
  final Expense exp;

  final DateFormat formatter = DateFormat('HH:mm');
  ExpenseTile({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      height: 72,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: const Color(0xff0071FF).withOpacity(0.1),
                  child: SvgPicture.asset(
                    exp.category,
                    fit: BoxFit.contain,
                    height: 43,
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
                            exp.expenseName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${DateFormat.d().format(exp.date)} ${DateFormat.MMM().format(exp.date)}    •  ${formatter.format(exp.date)}',
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
                      NumberFormat('#,##0.00').format(exp.amountSpent),
                      style: TextStyle(
                        fontSize: 14,
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
              padding: EdgeInsets.only(top: 5),
              child: Divider(
                indent: 2,
                endIndent: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
