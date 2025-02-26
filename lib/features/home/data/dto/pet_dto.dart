import 'package:json_annotation/json_annotation.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';

part 'pet_dto.g.dart';

@JsonSerializable()
class PetDto {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String age;  
  final String breed; 
  final String? description;
  final bool availability;
  @JsonKey(name: 'charge_per_hour')
  final String chargePerHour;
  final String? image;

  PetDto({
    required this.id,
    required this.name,
    required this.age, 
    required this.breed,
    this.description,
    required this.availability,
    required this.chargePerHour,
    this.image,
  });

  factory PetDto.fromJson(Map<String, dynamic> json) => _$PetDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PetDtoToJson(this);

  // Convert DTO to domain entity
  PetEntity toEntity() => PetEntity(
        id: id,
        name: name,
        age: age, 
        breed: breed,
        description: description ?? '',
        availability: availability,
        chargePerHour: chargePerHour,
        image: image ?? '',
      );

  // Convert Entity to DTO (if needed for sending data)
  static PetDto fromEntity(PetEntity pet) => PetDto(
        id: pet.id,
        name: pet.name,
        age: pet.age,
        breed: pet.breed,
        description: pet.description,
        availability: pet.availability,
        chargePerHour: pet.chargePerHour,
        image: pet.image,
      );
}

// Deserialize from list directly
List<PetDto> petDtoListFromJson(List<dynamic> json) =>
    json.map((e) => PetDto.fromJson(e)).toList();

List<Map<String, dynamic>> petDtoListToJson(List<PetDto> pets) =>
    pets.map((e) => e.toJson()).toList();
