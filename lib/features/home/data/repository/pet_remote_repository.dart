import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_remote_datasource.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/pet_repository.dart';

class PetRemoteRepository implements IPetRepository {
  final PetRemoteDataSource _petRemoteDataSource;

  PetRemoteRepository({required PetRemoteDataSource petRemoteDataSource})
      : _petRemoteDataSource = petRemoteDataSource;

  @override
  Future<Either<Failure, List<PetEntity>>> getPets() async {
    try {
      final pets = await _petRemoteDataSource.fetchPets();
      return Right(pets);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }
}
