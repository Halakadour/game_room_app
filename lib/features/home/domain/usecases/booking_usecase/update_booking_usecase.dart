import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/use_case.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

class UpdateBookingUsecase extends UseCase<void, BookingEntity> {
  final HomeRepo homeRepo;
  UpdateBookingUsecase(this.homeRepo);

  @override
  Either<Failure, void> call(BookingEntity param) {
    return homeRepo.updateBooking(param.id, param);
  }
}
