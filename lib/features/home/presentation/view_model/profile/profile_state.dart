part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? profilePicture;

  const ProfileState({
    required this.isLoading,
    required this.isSuccess,
    this.profilePicture,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      isSuccess: false,
      profilePicture: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? profilePicture,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, profilePicture];
}