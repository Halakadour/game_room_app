import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/features/home/data/datasources/home_local_datasource.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

import '../../../../core/error/handling_exception_manager.dart';

class HomeRepoImpl with HandlingExceptionManager implements HomeRepo {
  final HomeLocalDataSourceImpl homeLocalDataSourceImpl;
  HomeRepoImpl(
    this.homeLocalDataSourceImpl,
  );

  @override
  Either<Failure, void> addBooking(BookingEntity booking) {
    final result = homeLocalDataSourceImpl.addBooking(booking);
    return Right(result);
  }

  @override
  Either<Failure, void> addDevice(DeviceEntity device) {
    final result = homeLocalDataSourceImpl.addDevice(device);
    return Right(result);
  }

  @override
  Either<Failure, void> deleteBooking(BookingEntity booking) {
    final result = homeLocalDataSourceImpl.deleteBooking(booking);
    return Right(result);
  }

  @override
  Either<Failure, void> deleteDevice(String id) {
    final result = homeLocalDataSourceImpl.deleteDevice(id);
    return Right(result);
  }

  @override
  Either<Failure, BookingEntity?> getBookingByDeviceId(String deviceId) {
    final result = homeLocalDataSourceImpl.getBookingByDeviceId(deviceId);
    return Right(result);
  }

  @override
  Either<Failure, List<DeviceEntity>> getAllDevices() {
    final result = homeLocalDataSourceImpl.getAllDevices();
    return Right(result);
  }

  @override
  Either<Failure, void> updateBooking(String id, BookingEntity updatedBooking) {
    final result = homeLocalDataSourceImpl.updateBooking(id, updatedBooking);
    return Right(result);
  }

  @override
  Either<Failure, void> updateDevice(String id, DeviceEntity updatedDevice) {
    final result = homeLocalDataSourceImpl.updateDevice(id, updatedDevice);
    return Right(result);
  }

}
