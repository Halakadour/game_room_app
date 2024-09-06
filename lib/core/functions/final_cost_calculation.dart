import 'package:flutter/material.dart';
import 'package:games_manager/core/functions/calculate_time_difference.dart';

num calculateFinalCost(
    TimeOfDay startTime, TimeOfDay endTime, num costPerHour) {
  final difference = calculateTimeDifference(startTime, endTime);
  final totalCost = (difference.inMinutes / 60) * costPerHour;
  return totalCost;
}
