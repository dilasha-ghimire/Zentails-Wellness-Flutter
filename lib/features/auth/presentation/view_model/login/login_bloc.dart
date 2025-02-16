import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/login_usecase.dart';
import 'package:zentails_wellness/features/home/presentation/view/dashboard_screen/dashboard_view.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  bool _areFieldsFilled(String emailOrPhone, String password) {
    return emailOrPhone.isNotEmpty && password.isNotEmpty;
  }

  LoginBloc({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    // Handle navigation to register
    on<NavigateRegisterEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => event.destination,
          ),
        );
      },
    );

    // Handle login
    on<LoginUserEvent>((event, emit) async {
      if (!_areFieldsFilled(event.emailOrPhone, event.password)) {
        showMySnackBar(
          context: event.context,
          message: "All fields must be filled.",
        );
        return;
      }

      emit(state.copyWith(isLoading: true));
      final result = await _loginUseCase.call(
        LoginParams(
          emailOrPhone: event.emailOrPhone,
          password: event.password,
        ),
      );

      result.fold(
        (l) {
          // Failure case
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Login Failed. Try again.",
          );
        },
        (r) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ),
          );
        },
      );
    });
  }
}
