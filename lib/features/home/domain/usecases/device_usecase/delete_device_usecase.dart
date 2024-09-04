import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/use_case.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

class DeleteDeviceUsecase extends UseCase<void, String> {
  final HomeRepo homeRepo;
  DeleteDeviceUsecase(this.homeRepo);

  @override
  Either<Failure, void> call(String param) {
    return homeRepo.deleteDevice(param);
  }
}
