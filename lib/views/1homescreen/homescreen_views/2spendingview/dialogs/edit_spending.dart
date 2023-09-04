import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../data/views_data.dart';

class EditSpendingSD extends StatefulWidget {
  final SpendingModel spending;
  const EditSpendingSD({super.key, required this.spending});

  @override
  State<EditSpendingSD> createState() => _EditSpendingSDState();
}

class _EditSpendingSDState extends State<EditSpendingSD> {

  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Set Page for Edit Mode
  void _activeEditMode() {
    _titleController.text = widget.spending.name;
    _amountController.text = widget.spending.spendingAmount.toString();
  }

  @override
  void initState() {
    _activeEditMode();
    super.initState();
  }

  @override
  void dispose() {
    ViewData.spendings.clear();
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
                  "Edit Spending",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () => _onEdit(widget.spending),
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // User Input TextFields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: UserInputField(
                    controller: _titleController,
                    hintText: 'Budget Name',
                    isNumber: false,
                    autofocus: false,
                    onSubmitted: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: UserInputField(
                    controller: _amountController,
                    hintText: 'Budget Amount',
                    isNumber: true,
                    autofocus: false,
                    onSubmitted: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Adding editted Budget

  Future _onEdit(SpendingModel s) async {
    
    if (s.name == _titleController.text.trim() &&
        s.spendingAmount == double.parse(_amountController.text.trim())) {
      Navigator.of(context).pop();
    } else {
      // Save Spending Object
      s.name = _titleController.text.trim();
      s.spendingAmount = double.parse(_amountController.text.trim());

      s.save();
      Navigator.of(context).pop();
    }
  }

  // Dismiss Dialog
  Future _onCancel() async {
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }
}
