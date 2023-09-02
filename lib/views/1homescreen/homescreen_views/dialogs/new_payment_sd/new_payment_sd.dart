import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../data/data.dart';
import '../../../../../globalwidgtes/textinput.dart';
import '../../../../../models/budget-models/budgetmodel/budget.dart';
import '../../../../../data/data_validation.dart';
import '../../../../../models/hive/boxes.dart';
import '../../../../../data/views_data.dart';

class NewPaymentPage extends StatefulWidget {
  const NewPaymentPage({super.key});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  final DateFormat formatter = DateFormat('HH:mm');

  // Text Contollers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  ViewData a = ViewData();
  String _title = '';

  // Get Date Picker
  DateTime _selectedDate = DateTime.now();

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
    final List<String> arg =
        ModalRoute.of(context)!.settings.arguments as List<String>;

    final String svgPath = arg[0];
    final String title = arg[1];
    _title = title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: _onCancel,
          icon: const Icon(CupertinoIcons.xmark),
        ),
        actions: [
          IconButton(
            onPressed: () => _onSave(),
            icon: const Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
      body: Column(
        children: [
          // SVG Picture
          Center(
            child: Column(
              children: [
                Hero(
                  tag: svgPath,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      svgPath,
                      fit: BoxFit.cover,
                      height: 110,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${DateFormat.d().format(DateTime.now())} ${DateFormat.MMM().format(DateTime.now())}    •  ${formatter.format(DateTime.now())}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff929292),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // User Input TextFields
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _budgetMenu(context),
              ),
              Expanded(
                flex: 2,
                child: _spendingMenu(context),
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
                  autofocus: false,
                  onSubmitted: null,
                ),
              ),
              Expanded(
                flex: 2,
                child: UserInputField(
                  controller: _amountController,
                  hintText: 'Expense Amount',
                  isNumber: true,
                  autofocus: false,
                  onSubmitted: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Save Expense Item
  Future _onSave() async {
    List<int> ids = List<int>.filled(3, getRandom());
    ids[0] = _selectedBudgetObject.id;
    ids[1] = _spendingId;

    final sp = ExpenseModel(
      ids: ids,
      category: fileName(_title).toString(),
      expenseName: _titleController.text.trim(),
      amountSpent: double.parse(_amountController.text.trim()),
      date: _selectedDate,
    );

    updateData(
        _selectedBudgetObject, double.parse(_amountController.text.trim()));

    setState(() {
      Boxes.expenseBox().add(sp);
    });
    NotiViewData().budgetNoti(_selectedBudgetObject);
    NotiViewData().spendNoti(_selectedSpendingObject);

    _onCancel();
  }

  // Dismiss Dialog
  Future _onCancel() async {
    _selectedDate = DateTime.now();
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  // ----------------------------- get drop down selected items ------------------- //

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

  //Spending DropDown Menu Button
  List<String> _names = ['Select a budget'];
  String? _selectedSpending;
  int _spendingId = getRandom();
  late SpendingModel _selectedSpendingObject;
  void _getSpendingId(String value) {
    _selectedSpendingObject =
        ViewData.spendings.where((element) => element.name == value).first;
    _spendingId = _selectedSpendingObject.ids[1];
  }

  /// -------------------------------------------------------------------------- ///

  // ----------------------------- DropDown Menu Widgets ------------------- //

  Widget _budgetMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 3),
          child: Text(
            'Select Budget',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          //width: MediaQuery.of(context).size.width * 0.33,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 10, left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownButton<String>(
            value: _selectedBudget,
            dropdownColor: const Color(0xffF2F2FA),
            icon: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                CupertinoIcons.chevron_down,
                size: 15,
              ),
            ),
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
                  //width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _spendingMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 3),
          child: Text(
            'Select Spending',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Container(
          height: 55,
          alignment: Alignment.center,
          //width: MediaQuery.of(context).size.width * 0.77,
          padding: const EdgeInsets.only(right: 10, left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(26, 105, 105, 105),
          ),
          child: DropdownButton<String>(
            value: _selectedSpending,
            dropdownColor: const Color(0xffF2F2FA),
            icon: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                CupertinoIcons.chevron_down,
                size: 15,
              ),
            ),
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
                  //width: MediaQuery.of(context).size.width * 0.23,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
