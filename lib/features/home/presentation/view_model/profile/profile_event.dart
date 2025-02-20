part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UploadProfileImage extends ProfileEvent {
  final File file;

  const UploadProfileImage({
    required this.file,
  });
}