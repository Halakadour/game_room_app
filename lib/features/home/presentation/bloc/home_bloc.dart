import 'package:bloc/bloc.dart';
import 'package:games_manager/features/home/data/datasources/home_local_datasource.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/domain/usecases/booking_usecase/add_booking_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/booking_usecase/delete_booking_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/booking_usecase/get_booking_by_device_id_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/booking_usecase/update_booking_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/device_usecase/add_device_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/device_usecase/delete_device_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/device_usecase/get_all_devices_usecase.dart';
import 'package:games_manager/features/home/domain/usecases/device_usecase/update_device_usecase.dart';

import '../../data/repositories/home_repo_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    HomeRepoImpl homeRepoImpl = HomeRepoImpl(HomeLocalDataSourceImpl());
    on<GetDevicesListEvent>((event, emit) {
      final result = GetAllDevicesUsecase(homeRepoImpl).call();
      result.fold(
        (l) => emit(state.copyWith(deviceListStatus: Status.failed)),
        (r) => emit(
            state.copyWith(deviceListStatus: Status.fetched, deviceList: r)),
      );
    });
    on<AddDeviceEvent>((event, emit) {
      final result = AddDeviceUsecase(homeRepoImpl).call(event.device);
      result.fold(
        (l) => emit(state.copyWith(deviceListStatus: Status.failed)),
        (r) => emit(state.copyWith(deviceListStatus: Status.added)),
      );
    });
    on<UpdateDeviceEvent>((event, emit) {
      final result = UpdateDeviceUsecase(homeRepoImpl).call(event.device);
      result.fold(
        (l) => emit(state.copyWith(deviceListStatus: Status.failed)),
        (r) => emit(state.copyWith(deviceListStatus: Status.updated)),
      );
    });
    on<DeleteDeviceEvent>((event, emit) {
      final result = DeleteDeviceUsecase(homeRepoImpl).call(event.id);
      result.fold(
        (l) => emit(state.copyWith(deviceListStatus: Status.failed)),
        (r) => emit(state.copyWith(deviceListStatus: Status.deleted)),
      );
    });
    on<GetBookingByDeviceIdEvent>((event, emit) {
      final result =
          GetBookingByDeviceIdUsecase(homeRepoImpl).call(event.deviceId);
      result.fold(
        (l) => emit(state.copyWith(bookingItemStatus: Status.failed)),
        (r) => emit(
            state.copyWith(bookingItemStatus: Status.fetched, bookingItem: r)),
      );
    });
    on<AddBookingEvent>((event, emit) {
      final result = AddBookingUsecase(homeRepoImpl).call(event.booking);
      result.fold(
        (l) => emit(state.copyWith(bookingItemStatus: Status.failed)),
        (r) => emit(state.copyWith(bookingItemStatus: Status.added)),
      );
    });
    on<UpdateBookingEvent>((event, emit) {
      final result = UpdateBookingUsecase(homeRepoImpl).call(event.booking);
      result.fold(
        (l) => emit(state.copyWith(bookingItemStatus: Status.failed)),
        (r) => emit(state.copyWith(bookingItemStatus: Status.updated)),
      );
    });
    on<DeleteBookingEvent>((event, emit) {
      final result = DeleteBookingUsecase(homeRepoImpl).call(event.booking);
      result.fold(
        (l) => emit(state.copyWith(bookingItemStatus: Status.failed)),
        (r) => emit(state.copyWith(bookingItemStatus: Status.deleted)),
      );
    });
  }
}
