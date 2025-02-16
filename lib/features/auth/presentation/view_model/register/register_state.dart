part of 'register_bloc.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  factory RegisterState.initial() {
    return RegisterState(isLoading: false, isSuccess: false, errorMessage: null);
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
