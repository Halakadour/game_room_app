part of 'home_bloc.dart';

class HomeEvent {}

class GetDevicesListEvent extends HomeEvent {}

class AddDeviceEvent extends HomeEvent {
  DeviceEntity device;
  AddDeviceEvent({
    required this.device,
  });
}

class UpdateDeviceEvent extends HomeEvent {
  String id;
  DeviceEntity device;
  UpdateDeviceEvent({
    required this.id,
    required this.device,
  });
}

class ToggleDeviceIdelEvent extends HomeEvent {
  String deviceId;
  ToggleDeviceIdelEvent({
    required this.deviceId,
  });
}

class DeleteDeviceEvent extends HomeEvent {
  String id;
  DeleteDeviceEvent({
    required this.id,
  });
}

class GetBookingByDeviceIdEvent extends HomeEvent {
  String deviceId;
  GetBookingByDeviceIdEvent({
    required this.deviceId,
  });
}

class AddBookingEvent extends HomeEvent {
  BookingEntity booking;
  AddBookingEvent({
    required this.booking,
  });
}

class UpdateBookingEvent extends HomeEvent {
  String id;
  BookingEntity booking;
  UpdateBookingEvent({
    required this.id,
    required this.booking,
  });
}

class DeleteBookingEvent extends HomeEvent {
  String id;
  DeleteBookingEvent({
    required this.id,
  });
}
