import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';

abstract class IAppointmentDataSource {
  Future<void> bookAppointment(BookAppointmentEntity appointment);
  Future<List<TherapyBookingEntity>> getAppointmentsByUserId();
}
