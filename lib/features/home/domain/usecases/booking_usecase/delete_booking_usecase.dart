import 'package:dartz/dartz.dart';
import 'package:games_manager/core/error/failures.dart';
import 'package:games_manager/core/usecases/use_case.dart';
import 'package:games_manager/features/home/domain/entities/booking_entity.dart';
import 'package:games_manager/features/home/domain/repositories/home_repo.dart';

class DeleteBookingUsecase extends UseCase<void, BookingEntity> {
  final HomeRepo homeRepo;
  DeleteBookingUsecase(this.homeRepo);

  @override
  Either<Failure, void> call(BookingEntity param) {
    return homeRepo.deleteBooking(param);
  }
}
