import 'package:hive/hive.dart';

part 'device_entity.g.dart';

@HiveType(typeId: 0)
class DeviceEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int type;
  @HiveField(3)
  final num costPerHoure;
  @HiveField(4)
  bool idle;
  DeviceEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.costPerHoure,
    this.idle = true,
  });
}
