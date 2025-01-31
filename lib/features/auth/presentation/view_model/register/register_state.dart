part of 'register_bloc.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? profilePicture;

  RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.profilePicture,
  });

  factory RegisterState.initial() {
    return RegisterState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
      profilePicture: null,
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? profilePicture,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  List<Object?> get props =>
      [isLoading, isSuccess, errorMessage, profilePicture];
}
