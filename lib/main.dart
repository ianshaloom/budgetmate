import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 0, 56)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ));
}