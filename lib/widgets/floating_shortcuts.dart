import 'package:flutter/material.dart';

class ExpenseFloatingButtons extends StatelessWidget {
  final String totalAmount;
  final void Function()? onAdd;
  final void Function()? onClear;
  final int pageIndex;
  const ExpenseFloatingButtons({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.pageIndex,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: FloatingActionButton(
            //mini: true,
            onPressed: onAdd,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: FloatingActionButton(
            //mini: true,
            onPressed: onClear,
            child: const Icon(
              Icons.clear_all_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class BudgetFloatButtons extends StatelessWidget {
  final String totalAmount;
  final void Function()? onAdd;
  final void Function()? onClear;
  final int pageIndex;

  const BudgetFloatButtons({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.pageIndex,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: FloatingActionButton(
            //mini: true,
            onPressed: onAdd,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: FloatingActionButton(
            //mini: true,
            onPressed: onClear,
            child: const Icon(
              Icons.clear_all_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
