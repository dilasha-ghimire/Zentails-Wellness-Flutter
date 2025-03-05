part of 'book_appointment_bloc.dart';

class BookAppointmentState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool reloadData;
  final String? errorMessage;

  const BookAppointmentState({
    required this.isLoading,
    required this.isSuccess,
    required this.reloadData,
    this.errorMessage,
  });

  factory BookAppointmentState.initial() {
    return const BookAppointmentState(
      isLoading: false,
      isSuccess: false,
      reloadData: false,
      errorMessage: null,
    );
  }

  BookAppointmentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? reloadData,
    String? errorMessage,
  }) {
    return BookAppointmentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      reloadData: reloadData ?? this.reloadData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, reloadData, errorMessage];
}
