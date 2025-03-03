import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_details_remote_datasource.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/pet_details_repository.dart';

class PetDetailsRemoteRepository implements IPetDetailsRepository {
  final PetDetailsRemoteDataSource _petDetailsRemoteDataSource;

  PetDetailsRemoteRepository({required PetDetailsRemoteDataSource petDetailsRemoteDataSource})
      : _petDetailsRemoteDataSource = petDetailsRemoteDataSource;

  @override
  Future<Either<Failure, PetDetailsEntity>> getPetDetails(String petId) async {
    try {
      final petDetails = await _petDetailsRemoteDataSource.fetchPetDetails(petId);
      return Right(petDetails);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }
}
