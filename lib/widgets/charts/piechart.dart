import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/database/expense.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key, required this.recentExpences});

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
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DChartPie(
        data: chartData.map((e) {
          return {'domain': e['day'], 'measure': e['amount']};
        }).toList(),
        labelColor: const Color.fromARGB(148, 44, 49, 64),
        labelPosition: PieLabelPosition.outside,
        labelFontSize: 11,
        labelLineThickness: 0.7,
        labelLinelength: 10,
        fillColor: (pieData, index) {
          switch (pieData['domain']) {
            case 'Mon':
              return const Color(0xff003f5c);
            case 'Tue':
              return const Color(0xff374c80);
            case 'Wed':
              return const Color(0xff7a5195);
            case 'Thu':
              return const Color(0xffbc5090);
            case 'Fri':
              return const Color(0xffef5675);
            case 'Sat':
              return const Color(0xffff764a);
            case 'Sun':
              return const Color(0xffffa600);
          }
        },
        strokeWidth: 3,
      ),
    );
  }
}
