// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingEntityAdapter extends TypeAdapter<BookingEntity> {
  @override
  final int typeId = 1;

  @override
  BookingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingEntity(
      id: fields[0] as String,
      deviceId: fields[1] as String,
      clientName: fields[2] as String,
      startTime: fields[3] as TimeOfDay,
      endTime: fields[4] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, BookingEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deviceId)
      ..writeByte(2)
      ..write(obj.clientName)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
