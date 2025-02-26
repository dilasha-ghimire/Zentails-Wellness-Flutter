part of 'pet_bloc.dart';

class PetState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool reloadData;
  final List<PetEntity> pets;
  final String? errorMessage;

  const PetState({
    required this.isLoading,
    required this.isSuccess,
    required this.reloadData,
    required this.pets,
    this.errorMessage,
  });

  factory PetState.initial() {
    return const PetState(
      isLoading: false,
      isSuccess: false,
      reloadData: false,
      pets: [],
      errorMessage: null,
    );
  }

  PetState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? reloadData,
    List<PetEntity>? pets,
    String? errorMessage,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      reloadData: reloadData ?? this.reloadData,
      pets: pets ?? this.pets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        reloadData,
        pets,
        errorMessage,
      ];
}
