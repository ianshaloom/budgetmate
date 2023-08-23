import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../1homescreen/home_page.dart';
import '../2statisticsscreen/statistic_page.dart';
import '../3notificationscreen/notification_page.dart';
import '../4profilescreen/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _screens = [
    const HomePage(),
    const StatisticPage(),
    const NotificationPage(),
    const ProfilePage()
  ];
  int _index = 0;

  void _setCurrentScreen(int index) {
    setState(() {
      _index = index;
    });
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
      body: _screens[_index],

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
            'assets/icons/analytics.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
          SvgPicture.asset(
            'assets/icons/notification.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
          SvgPicture.asset(
            'assets/icons/profile.svg',
            fit: BoxFit.contain,
            height: 20,
          ),
        ],
        onTap: (index) => _setCurrentScreen(index),
      ),
    );
  }
}
