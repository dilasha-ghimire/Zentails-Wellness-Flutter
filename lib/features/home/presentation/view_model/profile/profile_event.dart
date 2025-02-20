part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentUser extends ProfileEvent {
  final BuildContext context;
  const LoadCurrentUser({required this.context});

  @override
  List<Object?> get props => [context];
}

class UpdateUserState extends ProfileEvent {}

class UploadProfileImage extends ProfileEvent {
  final BuildContext context;
  final File file;

  const UploadProfileImage({
    required this.file,
    required this.context,
  });

  @override
  List<Object?> get props => [context, file];
}

class UpdateUser extends ProfileEvent {
  final BuildContext context;
  final String authId;
  final String fullName;
  final String email;
  final String contactNumber;
  final String address;

  const UpdateUser({
    required this.context,
    required this.authId,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
  });

  @override
  List<Object?> get props =>
      [context, authId, fullName, email, contactNumber, address];
}

class Logout extends ProfileEvent {}
