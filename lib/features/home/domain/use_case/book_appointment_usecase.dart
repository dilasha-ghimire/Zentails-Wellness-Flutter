import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/book_appointment_repository.dart';

class BookAppointmentParams {
  final String date;
  final int startTime;
  final int endTime;
  final String status;
  final String petId;

  const BookAppointmentParams({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.petId,
  });
}

class BookAppointmentUseCase implements UseCaseWithParams<void, BookAppointmentParams> {
  final IAppointmentRepository repository;

  BookAppointmentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(BookAppointmentParams params) async {
    final appointment = BookAppointmentEntity(
      date: params.date,
      startTime: params.startTime,
      endTime: params.endTime,
      status: params.status,
      petId: params.petId,
    );

    return repository.bookAppointment(appointment);
  }
}
