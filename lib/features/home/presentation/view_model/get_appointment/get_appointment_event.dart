part of 'get_appointment_bloc.dart';

abstract class GetAppointmentEvent extends Equatable {
  const GetAppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends GetAppointmentEvent {
  final BuildContext context;

  const LoadAppointments({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}

class SelectAppointment extends GetAppointmentEvent {
  final String appointmentId;

  const SelectAppointment({required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}