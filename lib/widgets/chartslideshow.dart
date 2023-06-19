import 'package:flutter/material.dart';
import 'dart:async';

import '../database/expense.dart';
import 'charts/barchart.dart';
import 'charts/donutchart.dart';
import 'charts/piechart.dart';

class Chartslideshow extends StatefulWidget {
  final List<Expense> recentExpences;
  const Chartslideshow({super.key, required this.recentExpences});

  @override
  State<Chartslideshow> createState() => _ChartslideshowState();
}

class _ChartslideshowState extends State<Chartslideshow> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _cards = const [
    Card(child: Text('Card 1')),
    Card(child: Text('Card 2')),
    Card(child: Text('Card 3')),
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_currentPage < _cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.slowMiddle,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      //scrollDirection: Axis.vertical,
      controller: _pageController,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
      children: [
        DonutChart(recentExpences: widget.recentExpences),
        PieChart(recentExpences: widget.recentExpences),
        BarChart(recentExpences: widget.recentExpences),
      ],
    );
  }

  /*  Widget _chartHolder(Widget chart) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(75)), // Set the desired border radius value
      ),
      child: chart,
    );
  } */
}
