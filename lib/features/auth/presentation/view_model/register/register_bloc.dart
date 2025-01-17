import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    // Handle navigation to login
    on<NavigateLoginEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => event.destination,
          ),
        );
      },
    );

    // Handle register
    on<RegisterUser>((event, emit) async {
      if (event.password != event.confirmPassword) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Passwords do not match.",
          color: Colors.red,
        );
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await _registerUseCase.call(RegisterParams(
        fullName: event.fullName,
        email: event.email,
        address: event.address,
        contactNumber: event.contactNumber,
        password: event.password,
      ));

      result.fold(
        (l) {
          // Failure case
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Registration Failed. Try again.",
            color: Colors.red,
          );
        },
        (r) {
          // Success case
          emit(state.copyWith(isLoading: false, isSuccess: true));
          showMySnackBar(
            context: event.context,
            message: "Registration successful!",
            color: Colors.green,
          );
        },
      );
    });
  }
}
