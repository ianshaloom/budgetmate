import 'package:budgetmate/models/notification-model/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final Function delete;
  const NotificationTile({
    super.key,
    required this.notification,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: getColorFromHex(notification.color),
                  ),
                ),
                IconButton(
                  onPressed: () => delete(notification),
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Color(0xff666666),
                    size: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                notification.content,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", ""); // Remove the '#' symbol if present
    int colorValue = int.parse(hexColor, radix: 16); // Convert hex to int
    return Color(0xff000000 + colorValue); // Add 0xff as the alpha value
  }
}
