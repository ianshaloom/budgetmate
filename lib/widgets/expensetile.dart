import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  // expense tile data
  final String? id;
  final String title;
  final double amount;
  final DateTime date;
  final Function(BuildContext)? delete;

  // Constructor
  const ExpenseTile({
    super.key,
    this.id,
    required this.title,
    required this.amount,
    required this.date,
     required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    String exAmount = NumberFormat('#,##0.00').format(amount);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
      child: Slidable(
        endActionPane:  ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: delete,
              backgroundColor: const Color.fromARGB(255, 121, 0, 0),
              icon: Icons.delete_outlined,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.9),
                  child: const Icon(
                    CupertinoIcons.creditcard_fill,
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
                        "+ Ksh. $exAmount",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
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
        ),
      ),
    );
  }
}
