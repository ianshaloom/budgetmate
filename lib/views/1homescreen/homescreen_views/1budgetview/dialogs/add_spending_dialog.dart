import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../models/hive/boxes.dart';

class NewSpendingSD extends StatefulWidget {
  final int budgetID;
  const NewSpendingSD({super.key, required this.budgetID});

  @override
  State<NewSpendingSD> createState() => _NewSpendingSDState();
}

class _NewSpendingSDState extends State<NewSpendingSD> {
  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          //Header
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _onCancel,
                  icon: const Icon(CupertinoIcons.xmark),
                ),
                Text(
                  "New Spending",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () => _saveSpending(),
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Input TextFields
                UserInputField(
                  controller: _titleController,
                  hintText: 'Spending Name',
                  isNumber: false,
                  autofocus: false,
                  onSubmitted: null,
                ),
                UserInputField(
                  controller: _amountController,
                  hintText: 'Spending Amount',
                  isNumber: true,
                  autofocus: false,
                  onSubmitted: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _saveSpending() async {
    List<int> ids = List<int>.filled(2, getRandom());
    ids[0] = widget.budgetID;
    final sp = SpendingModel(
        ids: ids,
        name: _titleController.text.trim(),
        spendingAmount: double.parse(_amountController.text.trim()),
        spentAmount: null);

    setState(() {
      Boxes.spendingBox().add(sp);
    });

    _onCancel();
  }

  // Dismiss Dialog
  Future _onCancel() async {
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }
}
