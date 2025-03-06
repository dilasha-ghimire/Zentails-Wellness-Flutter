part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String emailOrPhone;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.emailOrPhone,
    required this.password,
  });
}

class NavigateRegisterEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterEvent({
    required this.context,
    required this.destination,
  });
}
