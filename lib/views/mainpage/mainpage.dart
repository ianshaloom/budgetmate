import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../1homescreen/home_page.dart';
import '../2dashboardscreen/dashboard_page.dart';
import '../3statisticsscreen/statistic_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _screens = [
    const HomePage(),
    const DashboardPage(),
    const StatisticPage(),
  ];
  int _index = 0;

  void _setCurrentScreen(int index) {
    setState(() {
      _index = index;
    });
  }

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, // SingleTickerProviderStateMixin provides the vsync
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    super.initState();
  }

  @override
  void dispose() {
    // close all boxes
    Hive.close();

    // close one box
    /* Hive.box('budget').close(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10,
      ),
      body: SizedBox(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          /* transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          }, */
          child: _screens[_index],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        height: 50,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          SvgPicture.asset(
            'assets/icons/home.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
          SvgPicture.asset(
            'assets/icons/add2.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
          SvgPicture.asset(
            'assets/icons/analytics.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
        ],
        onTap: (index) => _setCurrentScreen(index),
      ),
    );
  }
}
