import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';

abstract class IAppointmentDataSource {
  Future<void> bookAppointment(BookAppointmentEntity appointment);
}
