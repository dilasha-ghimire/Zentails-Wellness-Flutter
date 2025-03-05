import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';

import '../../../../core/error/failure.dart';
import '../entity/book_appointment_entity.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, void>> bookAppointment(
      BookAppointmentEntity appointment);
  Future<Either<Failure, List<TherapyBookingEntity>>> getAppointmentsByUserId();
}
