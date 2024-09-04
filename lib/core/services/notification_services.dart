import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
        id, title, body, platformChannelSpecifics);
  }

  void scheduleNotification(TimeOfDay endTime, num costPerHour) async {
  final notificationService = NotificationService();
  await notificationService.init();
  final now = DateTime.now();
  DateTime endDateTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
  if (endDateTime.isBefore(now)) {
    endDateTime = endDateTime.add(const Duration(days: 1));
  }
  final difference = endDateTime.difference(now);
  if (difference.isNegative) return; 
  final totalCost = (difference.inHours + (difference.inMinutes % 60 > 0 ? 1 : 0)) * costPerHour;
  await Future.delayed(difference, () {
    notificationService.showNotification(
      0, 
      'تنبيه حجز',
      'انتهى وقت الحجز. التكلفة النهائية: \$${totalCost.toStringAsFixed(2)}', 
    );
  });
}
}
