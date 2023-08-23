import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String content;
  final int index;
  final Function delete;
  final Color color;
  const NotificationTile({
    super.key,
    required this.title,
    required this.content,
    required this.index,
    required this.delete, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: color,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                IconButton(
                  onPressed: () => delete(index),
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Color(0xff666666),
                    size: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 11,
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
}
