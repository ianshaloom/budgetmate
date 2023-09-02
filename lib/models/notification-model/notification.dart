import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 3)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String color;

  @HiveField(4)
  String id;

  NotificationModel({
    required this.title,
    required this.content,
    required this.date,
    required this.color,
    required this.id,
  });
}
