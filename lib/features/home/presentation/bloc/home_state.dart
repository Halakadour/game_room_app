part of 'home_bloc.dart';

enum Status { inited, beginning, fetched, added, deleted, updated, failed }

class HomeState {
  List<DeviceEntity> deviceList;
  Status deviceListStatus;
  Status toggleDeviceIdelStatus;
  BookingEntity? bookingItem;
  Status bookingItemStatus;
  HomeState({
    this.deviceList = const [],
    this.deviceListStatus = Status.inited,
    this.toggleDeviceIdelStatus = Status.inited,
    this.bookingItem,
    this.bookingItemStatus = Status.inited,
  });
  HomeState copyWith({
    List<DeviceEntity>? deviceList,
    Status? deviceListStatus,
    Status? toggleDeviceIdelStatus,
    BookingEntity? bookingItem,
    Status? bookingItemStatus,
  }) {
    return HomeState(
      deviceList: deviceList ?? this.deviceList,
      deviceListStatus: deviceListStatus ?? this.deviceListStatus,
      toggleDeviceIdelStatus: toggleDeviceIdelStatus ?? this.toggleDeviceIdelStatus,
      bookingItem: bookingItem ?? this.bookingItem,
      bookingItemStatus: bookingItemStatus ?? this.bookingItemStatus,
    );
  }
}
