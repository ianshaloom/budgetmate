import 'package:budgetmate/views/3notificationscreen/notificationscreen_widgets.dart/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Clear All',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff929292)),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: 5,
            itemBuilder: (context, index) => NotificationTile(
              title: 'Something has happened',
              content:
                  'Lucas ipsum dolor sit amet chewbaccaaayla dantooine obi-wan atrivis',
              index: index,
              delete: delete,
              color: Colors.red,
            ),
          ))
        ],
      ),
    );
  }
}

void delete() {}
