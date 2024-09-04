import 'package:flutter/material.dart';

class FinalCostCalculation {
  num calculateFinalCost(
      TimeOfDay startTime, TimeOfDay endTime, num costPerHour) {
    final now = DateTime.now();
    DateTime startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    if (endDateTime.isBefore(now)) {
      endDateTime = endDateTime.add(const Duration(days: 1));
    }
    final difference = endDateTime.difference(startDateTime);
    final totalCost =
        (difference.inHours + (difference.inMinutes % 60 > 0 ? 1 : 0)) *
            costPerHour;
    return totalCost;
  }
}
