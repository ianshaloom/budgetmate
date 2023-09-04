import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/clean_up.dart';
import '../../../../../data/data.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';

class DeleteSpendingBS extends StatelessWidget {
  final SpendingModel spending;

  const DeleteSpendingBS({super.key, required this.spending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 100,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 13),
              child: Text(
                "Are you sure you want to delete ${spending.name}?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xff2c3140),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: const Color(0xffC10000),
                onPressed: () => _deleteSpending(spending, context),
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
              const SizedBox(
                width: 15,
              ),
              FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                label: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                icon: const Icon(CupertinoIcons.xmark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _deleteSpending(SpendingModel spending, BuildContext context) async {
    spending.delete();

    final Clean clean = Clean();

    // clean budget notifications
    final budget =
        GetMe.budgets.where((element) => element.id == spending.ids[0]).first;

    clean.cleanBgNoti(budget);

    // clean budget spending notifications ------------- //
    clean.cleanSpNoti(spending, true);
    // ------------------------------------------------- //

    // clean budget expenses
    clean.cleanExp(spending, false);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
