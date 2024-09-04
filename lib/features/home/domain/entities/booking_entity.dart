import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'booking_entity.g.dart';

@HiveType(typeId: 1)
class BookingEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String deviceId;
  @HiveField(2)
  final String clientName;
  @HiveField(3)
  final TimeOfDay startTime;
  @HiveField(4)
  final TimeOfDay endTime;
  BookingEntity({
    required this.id,
    required this.deviceId,
    required this.clientName,
    required this.startTime,
    required this.endTime,
  });
}
