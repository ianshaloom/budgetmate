import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../3expenseview/expense_dialog_view.dart';

class ExpenseSpTile extends StatefulWidget {
  final ExpenseModel expense;
  const ExpenseSpTile({super.key, required this.expense});

  @override
  State<ExpenseSpTile> createState() => _ExpenseSpTileState();
}

class _ExpenseSpTileState extends State<ExpenseSpTile> {
  final DateFormat formatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _expenseSD(context, widget.expense),
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                    backgroundColor: const Color(0xff0071FF).withOpacity(0),
                    child: SvgPicture.asset(
                      widget.expense.category,
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
                              widget.expense.expenseName,
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
                          '${DateFormat.d().format(widget.expense.date)} ${DateFormat.MMM().format(widget.expense.date)}    •  ${formatter.format(widget.expense.date)}',
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
                        NumberFormat('#,##0.00')
                            .format(widget.expense.amountSpent),
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _deleteExpense(ExpenseModel expense) async {
    expense.delete();
    Navigator.of(context).pop();
  }

  Future _expenseSD(BuildContext cxt, ExpenseModel expense) async {
    await showDialog(
      context: cxt,
      builder: (context) => ExpensePageSD(
        expense: expense,
        onPressed: _deleteExpense,
        inDash: false,
      ),
    );
  }
}
