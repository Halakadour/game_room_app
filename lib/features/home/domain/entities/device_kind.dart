import 'package:hive/hive.dart';


@HiveType(typeId: 2) 
enum DeviceKind {
  @HiveField(0)
  pc,
  
  @HiveField(1)
  xbox,
  
  @HiveField(2)
  playstation,
}