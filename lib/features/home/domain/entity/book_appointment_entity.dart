import 'package:equatable/equatable.dart';

class BookAppointmentEntity extends Equatable {
  final String date;
  final int startTime;
  final int endTime;
  final String status;
  final String petId;

  const BookAppointmentEntity({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.petId,
  });

  @override
  List<Object?> get props => [
        date,
        startTime,
        endTime,
        status,
        petId,
      ];
}
