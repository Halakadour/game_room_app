import 'package:dartz/dartz.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/use_case.dart';

class GetBookingByDeviceIdUsecase
    extends UseCase<Either<Failure, BookingEntity?>, String> {
  final HomeRepo homeRepo;
  GetBookingByDeviceIdUsecase(this.homeRepo);

  @override
  Either<Failure, BookingEntity?> call(String param) {
    return homeRepo.getBookingByDeviceId(param);
  }
}
