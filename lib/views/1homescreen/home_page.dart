import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/data.dart';
import '../../globalwidgtes/disable_list_glow.dart';
import '../../models/budget-models/budgetmodel/budget.dart';
import '../../models/hive/boxes.dart';
import 'homescreen_views/bottomsheets/notification-bs/notification.dart';
import 'homescreen_widgets/budget_tile_widget.dart';
import 'homescreen_widgets/payment_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1
                            //fontFamily: 'OpenSans',
                            ),
                      ),
                      GestureDetector(
                        onTap: () => _notificationBS(context),
                        child: _notification(context),
                      ),
                    ],
                  ),
                  Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff929292),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 250,
              child: ValueListenableBuilder(
                  valueListenable: Boxes.budgetBox().listenable(),
                  builder: (context, box, _) {
                    final budgets = box.values.toList().cast<BudgetModel>();
                    return box.isEmpty
                        ? SvgPicture.asset(
                            'assets/images/empty-budget.svg',
                            fit: BoxFit.contain,
                            //height: 250,
                          )
                        : BudgetView(budgets: budgets);
                  }),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment List',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/home_page/paymentlist_page/'),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              child: AntiListGlowWrapper(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        (MediaQuery.of(context).size.width * (1 / 3)),
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    List titles = categories;
                    List paths = categoriesMap.values.toList().cast<String>();
                    return PaymentTile(
                      title: titles[index],
                      svgPath: paths[index],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _notification(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 20,
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              height: 25,
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: ValueListenableBuilder(
                valueListenable: Boxes.notificationBox().listenable(),
                builder: (context, box, _) {
                  var n = box.values
                      .where((element) => element.title != 'seen')
                      .toList();
                  return CircleAvatar(
                    backgroundColor: n.isNotEmpty
                        ? const Color(0xffc90000)
                        : Colors.transparent,
                    radius: 4,
                  );
                },
              ))
        ],
      ),
    );
  }
  // ----------------------------------------------- //

  // Add new Item Dialog Functions ----------------- //
  Future _notificationBS(BuildContext cxt) async {
    var l = GetMe.notifications;
    for (var element in l) {
      print(element.id);
    }
    print(GetMe.notifications);
    await showModalBottomSheet(
      context: cxt,
      builder: (context) => const NotificationBS(),
    );
  }
  // ----------------------------------------------- //

  // Add new Budget Dialog Functions ----------------- //
  /* Future _newPaymentSD(BuildContext cxt, String title, String svgPath) async {
    await showDialog(
      context: cxt,
      builder: (context) => NewPaymentPage(
        title: title,
        svgPath: svgPath,
      ),
    );
  } */
  // ----------------------------------------------- //
}
