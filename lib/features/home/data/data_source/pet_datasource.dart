import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';

abstract class IPetDataSource {
  Future<List<PetEntity>> fetchPets();
}
