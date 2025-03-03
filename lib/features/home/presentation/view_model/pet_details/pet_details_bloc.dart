import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pet_details_usecase.dart';

part 'pet_details_event.dart';
part 'pet_details_state.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  final GetPetDetailsUseCase _getPetDetailsUseCase;

  PetDetailsBloc({required GetPetDetailsUseCase getPetDetailsUseCase})
      : _getPetDetailsUseCase = getPetDetailsUseCase,
        super(PetDetailsState.initial()) {
    on<LoadPetDetails>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await _getPetDetailsUseCase.call(event.petId);
      result.fold(
        (failure) => emit(state.copyWith(
            isLoading: false, errorMessage: "Failed to load pet details")),
        (petDetails) => emit(state.copyWith(
          isLoading: false,
          petDetails: petDetails,
          isSuccess: true,
        )),
      );
    });
  }
}
