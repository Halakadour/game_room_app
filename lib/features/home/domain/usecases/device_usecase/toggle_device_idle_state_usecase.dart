import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/use_case.dart';

import '../../repositories/home_repo.dart';

class ToggleDeviceIdleStateUsecase extends UseCase<void, String> {
  final HomeRepo homeRepo;
  ToggleDeviceIdleStateUsecase(
    this.homeRepo,
  );

  @override
  Either<Failure, void> call(String param) {
    return homeRepo.toggleDeviceIdelState(param);
  }
}
