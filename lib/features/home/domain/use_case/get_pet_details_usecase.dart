import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/pet_details_repository.dart';

class GetPetDetailsUseCase implements UseCaseWithParams<PetDetailsEntity, String> {
  final IPetDetailsRepository petDetailsRepository;

  GetPetDetailsUseCase(this.petDetailsRepository);

  @override
  Future<Either<Failure, PetDetailsEntity>> call(String petId) async {
    return await petDetailsRepository.getPetDetails(petId);
  }
}
