import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pets_usecase.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final GetPetsUseCase _getPetsUseCase;

  PetBloc({required GetPetsUseCase getPetsUseCase})
      : _getPetsUseCase = getPetsUseCase,
        super(PetState.initial()) {
    on<LoadPets>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _getPetsUseCase.call();
      result.fold(
        (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (pets) => emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          pets: pets,
        )),
      );
    });

    on<SelectPet>((event, emit) {
      emit(state.copyWith(selectedPetId: event.petId));
    });
  }
}
