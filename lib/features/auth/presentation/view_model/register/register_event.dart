part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final String fullName;
  final String email;
  final String address;
  final String contactNumber;
  final String password;
  final String confirmPassword;
  final String? profilePicture;
  final BuildContext context;

  const RegisterUser({
    required this.fullName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.password,
    required this.confirmPassword,
    this.profilePicture,
    required this.context,
  });
}

class NavigateLoginEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginEvent({
    required this.context,
    required this.destination,
  });
}
