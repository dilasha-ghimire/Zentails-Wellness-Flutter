import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_appointment_usecase.dart';

part 'get_appointment_event.dart';
part 'get_appointment_state.dart';

class GetAppointmentBloc
    extends Bloc<GetAppointmentEvent, GetAppointmentState> {
  final GetAppointmentsUseCase _getAppointmentsUseCase;

  GetAppointmentBloc({required GetAppointmentsUseCase getAppointmentsUseCase})
      : _getAppointmentsUseCase = getAppointmentsUseCase,
        super(GetAppointmentState.initial()) {
    on<LoadAppointments>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _getAppointmentsUseCase.call();
      result.fold(
        (l) => emit(state.copyWith(
            isLoading: false, isSuccess: false, errorMessage: l.message)),
        (appointments) => emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          appointments: appointments,
        )),
      );
    });

    on<SelectAppointment>((event, emit) {
      emit(state.copyWith(selectedAppointmentId: event.appointmentId));
    });
  }
}
