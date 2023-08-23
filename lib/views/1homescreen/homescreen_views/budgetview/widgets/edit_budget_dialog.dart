import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../models/data_validation.dart';
import '../../../../../models/hive/boxes.dart';
import '../../../../../models/views_data.dart';
import '../../dialogs/new_budget_dialog/widgets/spending_tile1.dart';

class EditBudgetSD extends StatefulWidget {
  final BudgetModel budget;
  const EditBudgetSD({super.key, required this.budget});

  @override
  State<EditBudgetSD> createState() => _EditBudgetSDState();
}

class _EditBudgetSDState extends State<EditBudgetSD> {
  List<Spending> _spendings =
      Boxes.spendingBox().values.toList().cast<Spending>();

  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Set Page for Edit Mode
  void _activeEditMode() {
    _titleController.text = widget.budget.name;
    _amountController.text = widget.budget.amount.toString();
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
    _spendings = _spendings
        .where((element) => element.ids[0] == widget.budget.id)
        .toList()
        .cast<Spending>();

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
                  "Edit Budget",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () => _onEdit(widget.budget),
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
                    onSubmitted: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: UserInputField(
                    controller: _amountController,
                    hintText: 'Budget Amount',
                    isNumber: true,
                    onSubmitted: null,
                  ),
                ),
              ],
            ),
          ),

          // Spending Items Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Spending Items',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Spendings List
          Flexible(
            fit: FlexFit.loose,
            child: _spendings.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      'assets/images/empty.svg',
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  )
                : GlowingOverscrollWrapper(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: _spendings.length,
                      itemBuilder: (context, index) {
                        return SpendingTile1(
                          index: index,
                          bsi: _spendings[index],
                          delete: _deleteSpending,
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  // Add deleted spendings to list
  final List<Spending> _toBeDeleted = [];
  void _deleteSpending(int index, Spending bsi) {
    print('object');
    setState(() {
      _toBeDeleted.add(bsi);
      _spendings.removeAt(index);
    });
    print(_toBeDeleted);
  }

  // Adding editted Budget

  Future _onEdit(BudgetModel budget) async {
    if (budget.name == _titleController.text.trim() &&
        budget.amount == double.parse(_amountController.text.trim()) &&
        _toBeDeleted.isEmpty) {
      Navigator.of(context).pop();
    } else {
      // Save Budget Object
      budget.name = _titleController.text.trim();
      budget.amount = double.parse(_amountController.text.trim());
      budget.save();

      // Delete Spendings in List
      for (var element in _toBeDeleted) {
        List<Expense> ex;
        Spending sp = element;

        ex = GetMe.expenses
            .where((element) => element.ids[1] == sp.ids[1])
            .toList()
            .cast<Expense>();

        if (ex.isEmpty) {
          sp.delete();
        } else {
          for (var element in ex) {
            Expense exp = element;
            exp.delete();
          }
          sp.delete();
        }
      }

      Navigator.of(context).pop();
    }
  }

  // Dismiss Dialog
  Future _onCancel() async {
    _toBeDeleted.clear;
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }
}
