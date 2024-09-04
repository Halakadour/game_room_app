import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/no_param_use_case.dart';
import 'package:games_manager/features/home/domain/entities/device_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

class GetAllDevicesUsecase
    extends NoParamUseCase<Either<Failure, List<DeviceEntity>>> {
  final HomeRepo homeRepo;
  GetAllDevicesUsecase(this.homeRepo);

  @override
  Either<Failure, List<DeviceEntity>> call() {
    return homeRepo.getAllDevices();
  }
}
