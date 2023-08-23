import 'package:budgetmate/models/data_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/data.dart';
import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../models/hive/boxes.dart';
import '../../../../../models/views_data.dart';

class NewExpenseSD extends StatefulWidget {
  const NewExpenseSD({super.key});

  @override
  State<NewExpenseSD> createState() => _NewExpenseSDState();
}

class _NewExpenseSDState extends State<NewExpenseSD> {
  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  final List<String> _dropdownItems = 
  categories;
  ViewData a = ViewData();

  void clearLists() {
    ViewData.budgetNames.clear();
    ViewData.budgets.clear();
    ViewData.spendings.clear();
    ViewData.spendingNames.clear();
  }

  @override
  void initState() {
    a.getBudgetsNames();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    clearLists();
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
                const EdgeInsets.only(top: 5, bottom: 5.0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _onCancel,
                  icon: const Icon(CupertinoIcons.xmark),
                ),
                Text(
                  "New Expense",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () => _onSave(),
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),

          _budgetMenu(context),
          _spendingMenu(context),

          const Divider(
            indent: 15,
            endIndent: 15,
          ),

          // Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //DropDown Menu Button
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: expenseCategoryMenu(context),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Container(
                            height: 55,
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 5),
                            child: FloatingActionButton.extended(
                              elevation: 0,
                              onPressed: _showDatePicker,
                              label: const Text(
                                'Pick Date',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              icon: const Icon(
                                CupertinoIcons.calendar_badge_plus,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // User Input TextFields
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: UserInputField(
                        controller: _titleController,
                        hintText: 'Expense Name',
                        isNumber: false,
                        onSubmitted: null,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: UserInputField(
                        controller: _amountController,
                        hintText: 'Expense Amount',
                        isNumber: true,
                        onSubmitted: null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  // Get and Save Selected Item
  String _selectedItem = 'General';
  void _getExpenseType(String value) {
    _selectedItem = fileName(value).toString();
  }

  // Save Expense Item
  void _onSave() {
    List<int> ids = List<int>.filled(3, getRandom());
    ids[0] = _selectedBudgetObject.id;
    ids[1] = _spendingId;

    final sp = Expense(
      ids: ids,
      category: _selectedItem,
      expenseName: _titleController.text.trim(),
      amountSpent: double.parse(_amountController.text.trim()),
      date: _selectedDate,
    );

    updateData(
        _selectedBudgetObject, double.parse(_amountController.text.trim()));
    setState(() {
      Boxes.expenseBox().add(sp);
    });
    _onCancel();
  }

  // Dismiss Dialog
  Future _onCancel() async {
    _selectedDate = DateTime.now();
    _titleController.clear();
    _amountController.clear();
    clearLists();
    Navigator.of(context).pop();
  }

  //
  //
  //

//Budget DropDown Menu Button

  String? _selectedBudget;
  late BudgetModel _selectedBudgetObject;
  void _getBudgetObject(String value) {
    setState(() {
      ViewData.spendingNames.clear();
    });

    _selectedBudgetObject =
        ViewData.budgets.where((element) => element.name == value).first;
    a.getSpendingNames(_selectedBudgetObject);
    setState(() {
      _names = ViewData.spendingNames;
    });
  }

  Widget _budgetMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10, bottom: 3),
          child: Text(
            'Select Budget',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.77,
          padding: const EdgeInsets.only(right: 10, left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownButton<String>(
            value: _selectedBudget,
            dropdownColor: const Color(0xffF2F2FA),
            icon: const Icon(CupertinoIcons.chevron_down),
            style: Theme.of(context).textTheme.bodyMedium,
            underline: const Center(),
            borderRadius: BorderRadius.circular(15),
            onChanged: (value) {
              _getBudgetObject(value!);
              setState(() {
                _selectedBudget = value;
                _selectedSpending = null;
              });
            },
            items: ViewData.budgetNames.map((String e) {
              return DropdownMenuItem<String>(
                value: e,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(e)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  //Spending DropDown Menu Button
  List<String> _names = ['Select a budget'];
  String? _selectedSpending;
  int _spendingId = getRandom();
  late Spending _selectedSpendingObject;
  void _getSpendingId(String value) {
    _selectedSpendingObject =
        ViewData.spendings.where((element) => element.name == value).first;
    _spendingId = _selectedSpendingObject.ids[1];
  }

  Widget _spendingMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10, bottom: 3),
          child: Text(
            'Select Spending',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.77,
          padding: const EdgeInsets.only(right: 10, left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownButton<String>(
            value: _selectedSpending,
            dropdownColor: const Color(0xffF2F2FA),
            icon: const Icon(CupertinoIcons.chevron_down),
            style: Theme.of(context).textTheme.bodyMedium,
            underline: const Center(),
            borderRadius: BorderRadius.circular(15),
            onChanged: (value) {
              _getSpendingId(value!);
              setState(() {
                _selectedSpending = value;
              });
            },
            items: _names.map((String e) {
              return DropdownMenuItem<String>(
                value: e,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(e)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  //Budget DropDown Menu Button
  Widget expenseCategoryMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            'Expense Type',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownMenu<String>(
            trailingIcon: const Icon(CupertinoIcons.chevron_down),
            width: 170,
            menuHeight: 300,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            onSelected: (value) => _getExpenseType(value!),

            // Text Decorations
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),

            // Menu Decorations
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xffF2F2FA),
              ),
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),

            // DropDown Menu Entries
            dropdownMenuEntries: _dropdownItems.map((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 15,
                      color: Color(0xff2c3140),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
