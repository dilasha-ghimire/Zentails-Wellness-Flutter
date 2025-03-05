import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/home/domain/use_case/book_appointment_usecase.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final BookAppointmentUseCase _bookAppointmentUseCase;

  BookAppointmentBloc({required BookAppointmentUseCase bookAppointmentUseCase})
      : _bookAppointmentUseCase = bookAppointmentUseCase,
        super(BookAppointmentState.initial()) {
    on<BookAppointmentRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = BookAppointmentParams(
        date: event.date,
        startTime: event.startTime,
        endTime: event.endTime,
        status: event.status,
        petId: event.petId,
      );

      final result = await _bookAppointmentUseCase.call(params);
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Booking unsuccessful, try again!",
          );
        },
        (result) {
          emit(state.copyWith(
              isLoading: false, isSuccess: true, reloadData: true));
        },
      );
    });
  }
}
