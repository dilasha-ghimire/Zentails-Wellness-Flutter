import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart'; // Import the appropriate entity
import 'package:zentails_wellness/features/home/domain/repository/book_appointment_repository.dart';

class GetAppointmentsUseCase
    implements UseCaseWithoutParams<List<TherapyBookingEntity>> {
  final IAppointmentRepository appointmentRepository;

  GetAppointmentsUseCase(this.appointmentRepository);

  @override
  Future<Either<Failure, List<TherapyBookingEntity>>> call() async {
    return await appointmentRepository.getAppointmentsByUserId();
  }
}
