import 'dart:math';

import 'package:flutter/material.dart';

late String _greeting;
String get greeting => determineGreeting();

String determineGreeting() {
  final currentTime = DateTime.now();
  final currentHour = currentTime.hour;

  if (currentHour < 12) {
    _greeting = 'Good Morning';
  } else if (currentHour < 17) {
    _greeting = 'Good Afternoon';
  } else {
    _greeting = 'Good Evening';
  }
  return _greeting;
}

// Get File name
String? fileName(String key) {
  String? filename;
  filename = categoriesMap[key];
  return filename;
}

//
final List<String> categories = [
  'General',
  'Bills',
  'Transport',
  'Shopping',
  'Food',
  'Drink',
  'Savings',
  'Health',
  'Gift',
  'Entertainment',
];
final Map<String, String> categoriesMap = {
  'General': "assets/images/category/general.svg",
  'Bills': "assets/images/category/bills.svg",
  'Transport': "assets/images/category/transport.svg",
  'Shopping': "assets/images/category/shopping.svg",
  'Food': "assets/images/category/food.svg",
  'Drink': "assets/images/category/drink.svg",
  'Savings': "assets/images/category/savings.svg",
  'Health': "assets/images/category/health.svg",
  'Gift': "assets/images/category/gift.svg",
  'Entertainment': "assets/images/category/entertainment.svg",
};


final List<Color> colors = [
  const Color(0xff92ba92),
  const Color(0xff660e60),
  const Color(0xff525e75),
  const Color(0xff008585),
  const Color(0xff2c4875),
  const Color(0xffbc5090),
  const Color(0xffff6361),
  const Color(0xff2D87BA),
  const Color(0xff6BBA2D),
  const Color(0xffFF5F36),
];

Color getcolor() {
  Color color;
  int i;
  i = Random().nextInt((colors.length)) + 0;
  color = colors[i];
  return color;
}
