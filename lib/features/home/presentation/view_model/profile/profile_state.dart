part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool reloadData;
  final String fullName;
  final String email;
  final String contactNumber;
  final String address;
  final String? profilePicture;
  final String? errorMessage;

  const ProfileState({
    required this.isLoading,
    required this.isSuccess,
    required this.reloadData,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
    this.profilePicture,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      isSuccess: false,
      reloadData: false,
      fullName: '',
      email: '',
      contactNumber: '',
      address: '',
      profilePicture: null,
      errorMessage: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? reloadData,
    String? fullName,
    String? email,
    String? contactNumber,
    String? address,
    String? profilePicture,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      reloadData: reloadData ?? this.reloadData,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      profilePicture: profilePicture ?? this.profilePicture,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        reloadData,
        fullName,
        email,
        contactNumber,
        address,
        profilePicture,
        errorMessage,
      ];
}
