import 'package:hive/hive.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/device_entity.dart';

abstract class HomeLocalDatasource {
  List<DeviceEntity> getAllDevices();

  void addDevice(DeviceEntity device);

  void updateDevice(String id, DeviceEntity updatedDevice);

  void deleteDevice(String id);

  BookingEntity? getBookingByDeviceId(String deviceId);

  void addBooking(BookingEntity booking);

  void updateBooking(String id, BookingEntity updatedBooking);

  void deleteBooking(BookingEntity booking);
}

class HomeLocalDataSourceImpl extends HomeLocalDatasource {
  final Box<DeviceEntity> deviceBox = Hive.box<DeviceEntity>("devices");

  final Box<BookingEntity> bookingBox = Hive.box<BookingEntity>("bookings");

  @override
  void addBooking(BookingEntity booking) {
    DeviceEntity device = deviceBox.values.firstWhere(
      (element) => element.id == booking.deviceId,
    );
    if (device.idle) {
      device.idle = false;
    }
    updateDevice(device.id, device);
    bookingBox.put(booking.id, booking);
  }

  @override
  void addDevice(DeviceEntity device) {
    deviceBox.put(device.id, device);
  }

  @override
  void deleteBooking(BookingEntity booking) {
     DeviceEntity device = deviceBox.values.firstWhere(
      (element) => element.id == booking.deviceId,
    );
    if (!device.idle) {
      device.idle = true;
    }
    updateDevice(device.id, device);
    bookingBox.delete(booking.id);
  }

  @override
  void deleteDevice(String id) {
    deviceBox.delete(id);
  }

  @override
  BookingEntity? getBookingByDeviceId(String deviceId) {
    for (int i = 0; i < bookingBox.length; i++) {
      BookingEntity? booking = bookingBox.get(i);
      if (booking!.deviceId == deviceId) {
        return booking;
      }
    }
    return null;
  }

  @override
  List<DeviceEntity> getAllDevices() {
    return deviceBox.values.toList();
  }

  @override
  void updateBooking(String id, BookingEntity updatedBooking) {
    bookingBox.put(id, updatedBooking);
  }

  @override
  void updateDevice(String id, DeviceEntity updatedDevice) {
    deviceBox.put(id, updatedDevice);
  }
}
