import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final int pageIndex;

  // expense tile data
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  // Constructor
  const ExpenseTile({
    super.key,
    required this.pageIndex,
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
        child: Card(
          elevation: 5,
          color: pageIndex == 0
              ? const Color(0xffaabdf8)
              : const Color(0xffffa600),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 30),
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    color: pageIndex == 0
                        ? const Color(0xffffa600)
                        : const Color(0xffaabdf8),
                  ),
                  child: Text(
                    amount.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(date),
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
