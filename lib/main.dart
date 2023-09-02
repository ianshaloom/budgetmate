import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/budget-models/budgetmodel/budget.dart';
import 'models/notification-model/notification.dart';
import 'utils/color_pallet.dart';
import 'utils/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode with the device upright
    DeviceOrientation.portraitDown, // Portrait mode with the device upside down
  ]);

  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(BudgetModelAdapter());
  print('1');
  Hive.registerAdapter(SpendingModelAdapter());
  print('2');
  Hive.registerAdapter(ExpenseModelAdapter());
  print('3');
  Hive.registerAdapter(NotificationModelAdapter());
  print('4');

  await Hive.openBox<BudgetModel>('budget');
  await Hive.openBox<SpendingModel>('spending');
  await Hive.openBox<ExpenseModel>('expense');
  await Hive.openBox<NotificationModel>('notification');
  await Hive.openBox('budgetmate');

  runApp(
    MaterialApp(
      title: 'Budget Mate',
      theme: ThemeData(
        primarySwatch: budgetmateColor,
        fontFamily: "Poppins",

        scaffoldBackgroundColor: Colors.white,

        // Appbar Theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),

        // Floating Buttons Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
        ),

        // Card Theme
        cardTheme: CardTheme(
          elevation: 0,
          color: const Color(0xffF2F2FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Text Theme
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontFamily: 'OpenSans'),
          bodyMedium: const TextStyle(
            fontSize: 18,
            color: Color(0xff2c3140),
            fontWeight: FontWeight.w300,
          ),
          bodySmall: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(148, 44, 49, 64),
            fontWeight: FontWeight.w500,
          ),

          //body labels
          labelSmall: TextStyle(
            fontSize: 12,
            color: const Color(0xffFFFFFF).withOpacity(0.6),
            fontFamily: 'OpenSans',
          ),
          labelMedium: const TextStyle(
            fontSize: 17,
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
          labelLarge: const TextStyle(
            fontSize: 18,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          modalElevation: 1,
          modalBackgroundColor: Colors.white,
          modalBarrierColor: Color.fromARGB(123, 44, 49, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            side: BorderSide(
              color: Color(0xff2c3140),
            ),
          ),
        ),

        // Icon Button Theme
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
            iconColor: MaterialStateProperty.all<Color?>(
              const Color(0xff2c3140),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    ),
  );
}
