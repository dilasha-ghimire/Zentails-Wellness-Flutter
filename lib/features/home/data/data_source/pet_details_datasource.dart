import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';

abstract class IPetDetailsDataSource {
  Future<PetDetailsEntity> fetchPetDetails(String petId);
}
