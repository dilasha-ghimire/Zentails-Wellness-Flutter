import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/data/data_source/book_appointment_remote_datasource.dart';
import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/book_appointment_repository.dart';

class AppointmentRemoteRepository implements IAppointmentRepository {
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;

  AppointmentRemoteRepository(
      {required AppointmentRemoteDataSource appointmentRemoteDataSource})
      : _appointmentRemoteDataSource = appointmentRemoteDataSource;

  @override
  Future<Either<Failure, void>> bookAppointment(
      BookAppointmentEntity appointment) async {
    try {
      await _appointmentRemoteDataSource.bookAppointment(appointment);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TherapyBookingEntity>>> getAppointmentsByUserId() async {
    try {
      final appointments =
          await _appointmentRemoteDataSource.getAppointmentsByUserId();
      return Right(appointments);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }
}
