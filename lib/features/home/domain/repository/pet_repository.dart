import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/pet_entity.dart';

abstract class IPetRepository {
  Future<Either<Failure, List<PetEntity>>> getPets();
}
