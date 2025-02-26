// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetDto _$PetDtoFromJson(Map<String, dynamic> json) => PetDto(
      id: json['_id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      breed: json['breed'] as String,
      description: json['description'] as String?,
      availability: json['availability'] as bool,
      chargePerHour: json['charge_per_hour'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PetDtoToJson(PetDto instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'breed': instance.breed,
      'description': instance.description,
      'availability': instance.availability,
      'charge_per_hour': instance.chargePerHour,
      'image': instance.image,
    };
