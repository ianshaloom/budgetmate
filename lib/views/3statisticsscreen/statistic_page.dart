import 'package:budgetmate/data/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/budget-models/budgetmodel/budget.dart';
import '../../data/views_data.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff929292)),
              ),
              Text(
                'History',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0071FF)),
              )
            ],
          ),
          Text(
            NumberFormat('#,##0.00').format(budgetBalance),
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000)),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _bg.length,
              itemBuilder: (context, index) {
                return _buildItemCard(index, _bg[index].name);
              },
            ),
          )
        ],
      ),
    );
  }

  final List<BudgetModel> _bg = GetMe.budgets;

  Widget _buildItemCard(int x, String cardTitle) {
    return InkWell(
      onTap: () {
        selectCard(x);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 00),
        curve: Curves.easeIn,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: x == index
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes the shadow position
                  ),
                ]
              : List.empty(),
          color: x == index ? Colors.white : Colors.transparent,
          border: Border.all(
            color: x == index ? Colors.transparent : Colors.transparent,
            style: BorderStyle.solid,
            width: 0.75,
          ),
        ),
        //height: 50.0,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            cardTitle,
            style: TextStyle(
              fontSize: 15,
              color: x == index ? Theme.of(context).primaryColor : Colors.black,
            ),
          ),
        )),
      ),
    );
  }

  selectCard(x) {
    setState(() {
      index = x;
      budgetBalance = _bg[x].amount - BudgetViewData().bGamountSpent(_bg[x]);
    });
  }

  @override
  void initState() {
    _bg.isEmpty
        ? budgetBalance = 0
        : budgetBalance =
            _bg[0].amount - BudgetViewData().bGamountSpent(_bg[0]);
    super.initState();
  }

  int index = 0;
  late double budgetBalance;
}
