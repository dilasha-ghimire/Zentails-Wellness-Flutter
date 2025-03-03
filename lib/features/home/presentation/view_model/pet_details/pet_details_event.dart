part of 'pet_details_bloc.dart';

sealed class PetDetailsEvent extends Equatable {
  const PetDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadPetDetails extends PetDetailsEvent {
  final String petId;

  const LoadPetDetails({required this.petId});

  @override
  List<Object> get props => [petId];
}