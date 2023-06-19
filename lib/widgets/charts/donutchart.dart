import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/database/expense.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({super.key, required this.recentExpences});

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
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = chartData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DChartPie(
        data: data,
        fillColor: (pieData, index) {
          switch (pieData['domain']) {
            case 'Mon':
              return const Color(0xff4d4fc5);
            case 'Tue':
              return const Color(0xff616ec2);
            case 'Wed':
              return const Color(0xff7a8abc);
            case 'Thu':
              return const Color(0xff95a4b4);
            case 'Fri':
              return const Color(0xffb2bda8);
            case 'Sat':
              return const Color(0xffd1d598);
            case 'Sun':
              return const Color(0xfff0ee81);
          }
        },
        pieLabel: (Map<dynamic, dynamic> pieData, int? index) {
          return pieData['domain'];
        },
        donutWidth: 20,
        labelColor: const Color.fromARGB(148, 44, 49, 64),
        labelPosition: PieLabelPosition.outside,
        labelFontSize: 11,
        labelLineThickness: 0.7,
        labelLinelength: 20,
      ),
    );
  }
}
