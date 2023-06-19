import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/database/expense.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key, required this.recentExpences});

  final List<Expense> recentExpences;

  List<Map<String, Object>> get chartData {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentExpences.length; i++) {
        if (recentExpences[i].date.day == weekDay.day &&
            recentExpences[i].date.month == weekDay.month &&
            recentExpences[i].date.year == weekDay.year) {
          totalSum += recentExpences[i].amount;
        }
      }
      return {'domain': DateFormat.E().format(weekDay), 'measure': totalSum};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = chartData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DChartBar(
        data: [
          {
            'id': 'Bar',
            'data': data,
          },
        ],
        domainLabelPaddingToAxisLine: 6,
        axisLineTick: 2,
        axisLinePointTick: 2,
        axisLinePointWidth: 0,
        axisLineColor: Colors.green,
        measureLabelPaddingToAxisLine: 6,
        barColor: (barData, index, id) => Colors.green,
        showBarValue: true,
      ),
    );
  }
}
