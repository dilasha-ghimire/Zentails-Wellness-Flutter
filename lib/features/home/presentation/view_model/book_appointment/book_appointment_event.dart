part of 'book_appointment_bloc.dart';

abstract class BookAppointmentEvent extends Equatable {
  const BookAppointmentEvent();

  @override
  List<Object> get props => [];
}

class BookAppointmentRequested extends BookAppointmentEvent {
  final String date;
  final int startTime;
  final int endTime;
  final String status;
  final String petId;
  final BuildContext context;

  const BookAppointmentRequested({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.petId,
    required this.context,
  });

  @override
  List<Object> get props => [
        date,
        startTime,
        endTime,
        status,
        petId,
        context,
      ];
}
