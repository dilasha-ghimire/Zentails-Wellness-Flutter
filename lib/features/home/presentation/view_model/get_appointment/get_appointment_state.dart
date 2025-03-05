part of 'get_appointment_bloc.dart';

class GetAppointmentState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool reloadData;
  final List<TherapyBookingEntity> appointments;
  final String? errorMessage;
  final String? selectedAppointmentId;

  const GetAppointmentState({
    required this.isLoading,
    required this.isSuccess,
    required this.reloadData,
    required this.appointments,
    this.errorMessage,
    this.selectedAppointmentId,
  });

  factory GetAppointmentState.initial() {
    return const GetAppointmentState(
      isLoading: false,
      isSuccess: false,
      reloadData: false,
      appointments: [],
      errorMessage: null,
      selectedAppointmentId: null,
    );
  }

  GetAppointmentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? reloadData,
    List<TherapyBookingEntity>? appointments,
    String? errorMessage,
    String? selectedAppointmentId,
  }) {
    return GetAppointmentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      reloadData: reloadData ?? this.reloadData,
      appointments: appointments ?? this.appointments,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAppointmentId:
          selectedAppointmentId ?? this.selectedAppointmentId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        reloadData,
        appointments,
        errorMessage,
        selectedAppointmentId
      ];
}
