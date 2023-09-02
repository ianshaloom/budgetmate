import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../models/hive/boxes.dart';
import '../../../../../data/views_data.dart';
import 'widgets/spending_tile1.dart';

class NewBudgetDialog extends StatefulWidget {
  final BudgetModel? budget;
  const NewBudgetDialog({super.key, required this.budget});

  @override
  State<NewBudgetDialog> createState() => _NewBudgetDialogState();
}

class _NewBudgetDialogState extends State<NewBudgetDialog> {
  // Text Contollers
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // Page Controller
  final _pageController = PageController();

  final budgets = Boxes.budgetBox().values.toList().cast<BudgetModel>();
  final ViewData a = ViewData();
  final int bgId = getRandom();

  // State Management -------- //
  @override
  void initState() {
    _activeEditMode();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    _titleController.dispose();
    _amountController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  // -------------------------- //

  // Set Page for Edit Mode
  void _activeEditMode() {
    if (widget.budget != null) {
      _selectedDate = widget.budget!.date;
      titleController.text = widget.budget!.name;
      amountController.text = widget.budget!.amount.toString();
    }
  }

  void _onPressed() {
    widget.budget != null ? _onEdit(widget.budget!) : _onSave();
  }

  // Page Management ------------------------------ //
  int index = 0;
  void newPageIndex(int value) {
    setState(() {
      index = value;
    });
  }

  void _switchPages(int pageIndex) {
    setState(() {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }
  // ---------------------------------------------- //

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: widget.budget != null
          ? _editBudgetWidget(context)
          : AntiListGlowWrapper(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => newPageIndex(value),
                children: [
                  Column(
                    children: [
                      //Header
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 15.0, left: 4, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _onCancel,
                              icon: const Icon(CupertinoIcons.xmark),
                            ),
                            Text(
                              "New Budget",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                              onPressed: _onSave,
                              icon: const Icon(CupertinoIcons.check_mark),
                            ),
                          ],
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            //Date Picker
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: 200,
                                height: 45,
                                child: Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            DateFormat.yMMMd()
                                                .format(_selectedDate),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: FloatingActionButton(
                                        onPressed: _showDatePicker,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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

                            // User Input TextFields
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: UserInputField(
                                controller: titleController,
                                hintText: 'Budget Name',
                                isNumber: false,
                                autofocus: false,
                                onSubmitted: null,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: UserInputField(
                                controller: amountController,
                                hintText: 'Budget Amount',
                                isNumber: true,
                                autofocus: false,
                                onSubmitted: null,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spending Items Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Spending Items',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () => _switchPages(1),
                              child: Text(
                                'New Item',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spendings List
                      ViewData.temporarySpendings.isEmpty
                          ? Flexible(
                              fit: FlexFit.loose,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/add.svg',
                                  fit: BoxFit.contain,
                                  height: 60,
                                ),
                              ),
                            )
                          : Flexible(
                              fit: FlexFit.loose,
                              child: AntiListGlowWrapper(
                                child: ListView.builder(
                                  itemCount: ViewData.temporarySpendings.length,
                                  itemBuilder: (context, index) {
                                    return SpendingTile1(
                                      index: index,
                                      bsi: ViewData.temporarySpendings[index],
                                      delete: _deleteSpending,
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),

                  // Page 2
                  _addNewSpendingItem(context),
                ],
              ),
            ),
    );
  }

  // Get Date Picker
  DateTime _selectedDate = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  // Adding a new Budget
  Future _onSave() async {
    final String bgTitle = titleController.text.trim();
    final double bgAmount = double.parse(amountController.text.trim());
    final DateTime bgDate = _selectedDate;

    // save budget
    final newBudget =
        BudgetModel(id: bgId, name: bgTitle, amount: bgAmount, date: bgDate);

    // save spending
    final List<SpendingModel> bgSpendings =
        ViewData.temporarySpendings.toList().cast<SpendingModel>();

    setState(() {
      Boxes.budgetBox().add(newBudget);
      Boxes.spendingBox().addAll(bgSpendings);
    });

    _onCancel();
  }

  // Adding editted Budget
  Future _onEdit(BudgetModel budget) async {
    budget.name = titleController.text.trim();
    budget.amount = double.parse(amountController.text.trim());
    budget.date = _selectedDate;

    budget.save();
    Navigator.of(context).pop();
  }

  // Dismiss Dialog
  Future _onCancel() async {
    ViewData.temporarySpendings.clear();
    _selectedDate = DateTime.now();
    titleController.clear();
    amountController.clear();
    Navigator.of(context).pop();
  }

  // Edit a Budget Widget Page
  Widget _editBudgetWidget(BuildContext context) {
    return Column(
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
                onPressed: _onPressed,
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
              //Date Picker
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: 200,
                  height: 45,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
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

              // User Input TextFields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: UserInputField(
                  controller: titleController,
                  hintText: 'Budget Name',
                  isNumber: false,
                  autofocus: false,
                  onSubmitted: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: UserInputField(
                  controller: amountController,
                  hintText: 'Budget Amount',
                  isNumber: true,
                  autofocus: false,
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
          child: Center(
            child: SvgPicture.asset(
              'assets/images/add.svg',
              fit: BoxFit.contain,
              height: 60,
            ),
          ),
        )
      ],
    );
  }

// New Spending Widget Page ----------------------------------------------- ///

  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Widget _addNewSpendingItem(BuildContext context) {
    return Column(
      children: [
        //Header
        Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _switchPages(0),
                icon: const Icon(CupertinoIcons.back),
              ),
              Text(
                "New Spending Item",
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
                hintText: 'Spending Amountt',
                isNumber: true,
                autofocus: false,
                onSubmitted: null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _saveSpending() {
    List<int> ids = List<int>.filled(2, getRandom());
    ids[0] = bgId;
    final spending = SpendingModel(
        ids: ids,
        name: _titleController.text.trim(),
        spendingAmount: double.parse(_amountController.text.trim()),
        spentAmount: 0.0);

    ViewData.temporarySpendings.add(spending);

    _titleController.clear();
    _amountController.clear();
    _switchPages(0);
  }

  void _deleteSpending(int index) {
    setState(() {
      ViewData.temporarySpendings.removeAt(index);
    });
  }
}
