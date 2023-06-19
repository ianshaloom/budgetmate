import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetTile extends StatelessWidget {
  // expense tile data
  final String? id;
  final String title;
  final double amount;
  final DateTime date;

  // Constructor
  const BudgetTile({
    super.key,
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String bgAmount = NumberFormat('#,##0.00').format(amount);
    return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 10),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.9),
                  child: const Icon(
                    CupertinoIcons.bag_fill_badge_plus,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        "Ksh. $bgAmount",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Text(title,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        DateFormat.yMMMd().format(date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
