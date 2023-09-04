import 'package:budgetmate/views/1homescreen/homescreen_views/notification-bs/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../globalwidgtes/disable_list_glow.dart';
import '../../../../models/hive/boxes.dart';
import '../../../../models/notification-model/notification.dart';


class NotificationBS extends StatefulWidget {
  const NotificationBS({super.key});

  @override
  State<NotificationBS> createState() => _NotificationBSState();
}

class _NotificationBSState extends State<NotificationBS> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => clearAll(alert),
                  child: Text(
                    'Clear all',
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
          Flexible(
            fit: FlexFit.tight,
            child: AntiListGlowWrapper(
              child: ValueListenableBuilder(
                valueListenable: Boxes.notificationBox().listenable(),
                builder: (context, value, _) {
                  var n = value.values
                      .where((element) => element.title != 'seen')
                      .toList();
                  List<NotificationModel> notification =
                      n.reversed.toList().cast<NotificationModel>();
                  alert = notification;

                  return notification.isEmpty
                      ? Center(
                          child: SvgPicture.asset(
                            'assets/images/empty.svg',
                            fit: BoxFit.contain,
                            height: 100,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: notification.length,
                          itemBuilder: (context, index) {
                            return NotificationTile(
                              notification: notification[index],
                              delete: delete,
                            );
                          },
                        );
                },
              ),

              /* , */
            ),
          )
        ],
      ),
    );
  }

  List<NotificationModel> alert = [];

  Future delete(NotificationModel notification) async {
    notification.title = 'seen';
    notification.save();
  }

  Future clearAll(List<NotificationModel> alert) async {
    for (var element in alert) {
      element.title = "seen";
      await element.save();
    }
  }
}
