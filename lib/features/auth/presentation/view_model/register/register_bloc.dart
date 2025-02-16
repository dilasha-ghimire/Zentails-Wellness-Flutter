import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool _isValidContactNumber(String contactNumber) {
    return RegExp(r'^\d{10}$').hasMatch(contactNumber);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  bool _areFieldsFilled(RegisterUser event) {
    return event.fullName.isNotEmpty &&
        event.email.isNotEmpty &&
        event.address.isNotEmpty &&
        event.contactNumber.isNotEmpty &&
        event.password.isNotEmpty &&
        event.confirmPassword.isNotEmpty;
  }

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
      if (!_areFieldsFilled(event)) {
        showMySnackBar(
          context: event.context,
          message: "All fields must be filled.",
        );
        return;
      }

      if (!_isValidEmail(event.email)) {
        showMySnackBar(
          context: event.context,
          message: "Enter a valid email address.",
        );
        return;
      }

      if (!_isValidContactNumber(event.contactNumber)) {
        showMySnackBar(
          context: event.context,
          message: "Enter a valid 10-digit contact number.",
        );
        return;
      }

      if (!_isValidPassword(event.password)) {
        showMySnackBar(
          context: event.context,
          message: "Password must be at least 8 characters long.",
        );
        return;
      }

      if (event.password != event.confirmPassword) {
        showMySnackBar(
          context: event.context,
          message: "Passwords do not match.",
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
