import 'package:hive/hive.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/device_entity.dart';

abstract class HomeLocalDatasource {
  List<DeviceEntity> getAllDevices();

  void addDevice(DeviceEntity device);

  void updateDevice(String id, DeviceEntity updatedDevice);

  void toggleDeviceIdelState(String deviceId);

  void deleteDevice(String id);

  BookingEntity? getBookingByDeviceId(String deviceId);

  void addBooking(BookingEntity booking);

  void updateBooking(String id, BookingEntity updatedBooking);

  void deleteBooking(String id);
}

class HomeLocalDataSourceImpl extends HomeLocalDatasource {
  final Box<DeviceEntity> deviceBox = Hive.box<DeviceEntity>("devices");

  final Box<BookingEntity> bookingBox = Hive.box<BookingEntity>("bookings");

  @override
  void addBooking(BookingEntity booking) {
    bookingBox.put(booking.id, booking);
  }

  @override
  void addDevice(DeviceEntity device) {
    deviceBox.put(device.id, device);
  }

  @override
  void deleteBooking(String id) {
    bookingBox.delete(id);
  }

  @override
  void deleteDevice(String id) {
    deviceBox.delete(id);
  }

  @override
  BookingEntity? getBookingByDeviceId(String deviceId) {
    BookingEntity? booking = bookingBox.values.firstWhere(
      (booking) => booking.deviceId == deviceId,
    );
    return booking;
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

  @override
  Future<void> toggleDeviceIdelState(String deviceId) async {
    DeviceEntity? device =
        deviceBox.values.firstWhere((device) => device.id == deviceId);
    if (device.idle) {
      print('Device is available');
    } else {
      print('Device is already booked.');
    }
    device.idle = !device.idle;
    await deviceBox.put(deviceId, device);
  }
}
