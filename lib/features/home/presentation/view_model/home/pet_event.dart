part of 'pet_bloc.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

class LoadPets extends PetEvent {
  final BuildContext context;
  const LoadPets({required this.context});

  @override
  List<Object?> get props => [context];
}