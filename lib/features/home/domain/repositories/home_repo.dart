import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';

abstract class HomeRepo {
  Either<Failure, List<DeviceEntity>> getAllDevices();

  Either<Failure, void> addDevice(DeviceEntity device);

  Either<Failure, void> updateDevice(String id, DeviceEntity updatedDevice);

  Either<Failure, void> deleteDevice(String id);

  Either<Failure, BookingEntity?> getBookingByDeviceId(String deviceId);

  Either<Failure, void> addBooking(BookingEntity booking);

  Either<Failure, void> updateBooking(String id, BookingEntity updatedBooking);

  Either<Failure, void> deleteBooking(BookingEntity booking);
}
