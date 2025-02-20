part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentUser extends ProfileEvent {}

class UpdateUserState extends ProfileEvent {}

class UploadProfileImage extends ProfileEvent {
  final File file;

  const UploadProfileImage({required this.file});

  @override
  List<Object?> get props => [file];
}

class UpdateUser extends ProfileEvent {
  final String authId;
  final String fullName;
  final String email;
  final String contactNumber;
  final String address;

  const UpdateUser({
    required this.authId,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
  });

  @override
  List<Object?> get props => [authId, fullName, email, contactNumber, address];
}
