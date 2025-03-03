import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/pet_details_entity.dart';

abstract class IPetDetailsRepository {
  Future<Either<Failure, PetDetailsEntity>> getPetDetails(String petId);
}
