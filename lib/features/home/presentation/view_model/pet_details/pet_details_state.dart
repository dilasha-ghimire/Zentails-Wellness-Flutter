part of 'pet_details_bloc.dart';

class PetDetailsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final PetDetailsEntity? petDetails;

  const PetDetailsState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.petDetails,
  });

  factory PetDetailsState.initial() {
    return const PetDetailsState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
      petDetails: null,
    );
  }

  PetDetailsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    PetDetailsEntity? petDetails,
  }) {
    return PetDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      petDetails: petDetails ?? this.petDetails,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, petDetails];
}
