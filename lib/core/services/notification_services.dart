import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:games_manager/core/functions/final_cost_calculation.dart';
import 'package:games_manager/features/home/presentation/bloc/home_bloc.dart';

import '../functions/calculate_time_difference.dart';

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

  void scheduleNotification(
      TimeOfDay startTime, TimeOfDay endTime, num costPerHour) async {
    final notificationService = NotificationService();
    await notificationService.init();
    final difference = calculateTimeDifference(startTime, endTime);
    final totalCost = calculateFinalCost(startTime, endTime, costPerHour);
    await Future.delayed(difference, () {
      notificationService.showNotification(
        0,
        'تنبيه حجز',
        'انتهى وقت الحجز. التكلفة النهائية: \$${totalCost.toStringAsFixed(2)}',
      );
    });
  }
}
