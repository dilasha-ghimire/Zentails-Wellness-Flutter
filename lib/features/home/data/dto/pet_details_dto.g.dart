// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PetDetailsDtoToJson(PetDetailsDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'breed': instance.breed,
      'availability': instance.availability,
      'charge_per_hour': instance.chargePerHour,
      'description': instance.description,
      'image': instance.image,
      'healthRecord': instance.healthRecord,
      'medicalHistory': instance.medicalHistory,
      'specialNeeds': instance.specialNeeds,
      'vaccinations': instance.vaccinations,
    };

HealthRecordDto _$HealthRecordDtoFromJson(Map<String, dynamic> json) =>
    HealthRecordDto(
      id: json['_id'] as String,
      petId: json['pet_id'] as String,
      lastCheckupDate: json['last_checkup_date'] as String,
    );

Map<String, dynamic> _$HealthRecordDtoToJson(HealthRecordDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pet_id': instance.petId,
      'last_checkup_date': instance.lastCheckupDate,
    };

MedicalHistoryDto _$MedicalHistoryDtoFromJson(Map<String, dynamic> json) =>
    MedicalHistoryDto(
      id: json['_id'] as String,
      healthRecordId: json['health_record_id'] as String,
      condition: json['condition'] as String,
      treatmentDate: json['treatment_date'] as String,
    );

Map<String, dynamic> _$MedicalHistoryDtoToJson(MedicalHistoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'health_record_id': instance.healthRecordId,
      'condition': instance.condition,
      'treatment_date': instance.treatmentDate,
    };

SpecialNeedsDto _$SpecialNeedsDtoFromJson(Map<String, dynamic> json) =>
    SpecialNeedsDto(
      id: json['_id'] as String,
      healthRecordId: json['health_record_id'] as String,
      specialNeed: json['special_need'] as String,
    );

Map<String, dynamic> _$SpecialNeedsDtoToJson(SpecialNeedsDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'health_record_id': instance.healthRecordId,
      'special_need': instance.specialNeed,
    };

VaccinationDto _$VaccinationDtoFromJson(Map<String, dynamic> json) =>
    VaccinationDto(
      id: json['_id'] as String,
      healthRecordId: json['health_record_id'] as String,
      vaccineName: json['vaccine_name'] as String,
      vaccinationDate: json['vaccination_date'] as String,
    );

Map<String, dynamic> _$VaccinationDtoToJson(VaccinationDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'health_record_id': instance.healthRecordId,
      'vaccine_name': instance.vaccineName,
      'vaccination_date': instance.vaccinationDate,
    };
