import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/pet_repository.dart';

class GetPetsUseCase implements UseCaseWithoutParams<List<PetEntity>> {
  final IPetRepository petRepository;

  GetPetsUseCase(this.petRepository);

  @override
  Future<Either<Failure, List<PetEntity>>> call() async {
    return await petRepository.getPets();
  }
}
