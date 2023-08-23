import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/budget-models/budgetmodel/budget.dart';
import '../../models/hive/boxes.dart';

class DeleteBudgetBS extends StatelessWidget {
  final Function onPressed;
  final BudgetModel budget;
  final budgets = Boxes.budgetBox().values.toList().cast<BudgetModel>();

  DeleteBudgetBS({super.key, required this.onPressed, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 100,
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 13),
              child: Text(
                "Are you sure you want to clear budget?",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                onPressed: () => onPressed(budget),
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
}
