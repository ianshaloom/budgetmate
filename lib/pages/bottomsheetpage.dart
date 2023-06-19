import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/textinput.dart';

class BottomSheetContent extends StatefulWidget {
  final Function addExpense;
  final Function addBudget;
  final int pageIndex;

  const BottomSheetContent({
    super.key,
    required this.pageIndex,
    required this.addExpense,
    required this.addBudget,
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  // Contollers
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // validate and save data
  void saveData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    final date = _selectedDate;

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.pageIndex == 0
        ? widget.addExpense(title, amount, date)
        : widget.addBudget(title, amount, date);
    onCancel();
  }

  // cance and exit form
  void onCancel() {
    titleController.clear();
    amountController.clear();
    Navigator.of(context).pop();
  }

  // Get Date Picker
  DateTime _selectedDate = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        print(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onCancel,
                  icon: const Icon(CupertinoIcons.xmark),
                ),
                Text(
                  widget.pageIndex == 0 ? "New Expense" : "New Budget",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: saveData,
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: 300,
              height: 45,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Center(
                        child: Text(DateFormat.yMMMd().format(_selectedDate)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: FloatingActionButton(
                      onPressed: _showDatePicker,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.calendar_badge_plus,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          UserInputField(
            controller: titleController,
            hintText: widget.pageIndex == 0 ? "Expense Title" : "Budget Title",
            isNumber: false,
            onSubmitted: (p0) {},
          ),
          UserInputField(
            controller: amountController,
            hintText:
                widget.pageIndex == 0 ? "Expense Amount" : "Budget Amount",
            isNumber: true,
            onSubmitted: (_) => saveData(),
          ),
        ],
      ),
    );
  }
}

/* 
FilledButton.tonal(
                onPressed: saveData,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ), */
