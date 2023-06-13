import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Budget Mate',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xffbc5090),
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
