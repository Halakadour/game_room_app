import 'package:flutter/material.dart';

Duration calculateTimeDifference(TimeOfDay startTime, TimeOfDay endTime) {
  final now = DateTime.now();
  DateTime startDateTime =
      DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
  DateTime endDateTime =
      DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
  if (endDateTime.isBefore(now)) {
    endDateTime = endDateTime.add(const Duration(days: 1));
  }
  final difference = endDateTime.difference(startDateTime);
  return difference;
}
