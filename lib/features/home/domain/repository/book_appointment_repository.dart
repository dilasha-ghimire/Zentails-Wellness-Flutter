import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/book_appointment_entity.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, void>> bookAppointment(
      BookAppointmentEntity appointment);
}
