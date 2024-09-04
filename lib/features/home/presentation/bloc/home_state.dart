part of 'home_bloc.dart';

enum Status { inited,fetched, added, deleted, updated, failed }

class HomeState {
  List<DeviceEntity> deviceList;
  Status deviceListStatus;
  BookingEntity? bookingItem;
  Status bookingItemStatus;
  HomeState({
     this.deviceList = const [],
     this.deviceListStatus = Status.inited,
     this.bookingItem,
     this.bookingItemStatus = Status.inited,
  });
  HomeState copyWith({
    List<DeviceEntity>? deviceList,
    Status? deviceListStatus,
    BookingEntity? bookingItem,
    Status? bookingItemStatus,
  }) {
    return HomeState(
      deviceList: deviceList ?? this.deviceList,
      deviceListStatus: deviceListStatus ?? this.deviceListStatus,
      bookingItem: bookingItem ?? this.bookingItem,
      bookingItemStatus: bookingItemStatus ?? this.bookingItemStatus,
    );
  }
}
