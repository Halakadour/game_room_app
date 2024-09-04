import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/use_case.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

class UpdateDeviceUsecase extends UseCase<void, DeviceEntity> {
  final HomeRepo homeRepo;
  UpdateDeviceUsecase(this.homeRepo);

  @override
  Either<Failure, void> call(DeviceEntity param) {
    return homeRepo.updateDevice(param.id, param);
  }
}
