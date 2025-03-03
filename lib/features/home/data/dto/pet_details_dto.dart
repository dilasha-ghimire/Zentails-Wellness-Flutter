import 'package:json_annotation/json_annotation.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';

part 'pet_details_dto.g.dart';

@JsonSerializable()
class PetDetailsDto {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String age;
  final String breed;
  final bool availability;
  @JsonKey(name: 'charge_per_hour')
  final String chargePerHour;
  final String? description;
  final String? image;
  final HealthRecordDto? healthRecord;
  final List<MedicalHistoryDto> medicalHistory;
  final List<SpecialNeedsDto> specialNeeds;
  final List<VaccinationDto> vaccinations;

  PetDetailsDto({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.availability,
    required this.chargePerHour,
    this.description,
    this.image,
    this.healthRecord,
    this.medicalHistory = const [],
    this.specialNeeds = const [],
    this.vaccinations = const [],
  });

  /// **Fixed JSON Parsing**
  factory PetDetailsDto.fromJson(Map<String, dynamic> json) {
    final petJson = json['pet'] ?? {}; // Extract `pet` object from API response
    return PetDetailsDto(
      id: petJson['_id'] as String? ?? '',
      name: petJson['name'] as String? ?? '',
      age: petJson['age'] as String? ?? '',
      breed: petJson['breed'] as String? ?? '',
      availability: petJson['availability'] as bool? ?? false,
      chargePerHour: petJson['charge_per_hour'] as String? ?? '',
      description: petJson['description'] as String?,
      image: petJson['image'] as String?,
      healthRecord: json['healthRecord'] != null
          ? HealthRecordDto.fromJson(json['healthRecord'])
          : null,
      medicalHistory: (json['medicalHistory'] as List<dynamic>?)
              ?.map((e) => MedicalHistoryDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      specialNeeds: (json['specialNeeds'] as List<dynamic>?)
              ?.map((e) => SpecialNeedsDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      vaccinations: (json['vaccinations'] as List<dynamic>?)
              ?.map((e) => VaccinationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => _$PetDetailsDtoToJson(this);

  PetDetailsEntity toEntity() => PetDetailsEntity(
        id: id,
        name: name,
        age: age,
        breed: breed,
        availability: availability,
        chargePerHour: chargePerHour,
        description: description,
        image: image,
        healthRecord: healthRecord?.toEntity(),
        medicalHistory: medicalHistory.map((e) => e.toEntity()).toList(),
        specialNeeds: specialNeeds.map((e) => e.toEntity()).toList(),
        vaccinations: vaccinations.map((e) => e.toEntity()).toList(),
      );

  static PetDetailsDto fromEntity(PetDetailsEntity pet) => PetDetailsDto(
        id: pet.id,
        name: pet.name,
        age: pet.age,
        breed: pet.breed,
        availability: pet.availability,
        chargePerHour: pet.chargePerHour,
        description: pet.description,
        image: pet.image,
        healthRecord: pet.healthRecord != null
            ? HealthRecordDto.fromEntity(pet.healthRecord!)
            : null,
        medicalHistory:
            pet.medicalHistory.map((e) => MedicalHistoryDto.fromEntity(e)).toList(),
        specialNeeds:
            pet.specialNeeds.map((e) => SpecialNeedsDto.fromEntity(e)).toList(),
        vaccinations:
            pet.vaccinations.map((e) => VaccinationDto.fromEntity(e)).toList(),
      );
}

@JsonSerializable()
class HealthRecordDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'pet_id')
  final String petId;
  @JsonKey(name: 'last_checkup_date')
  final String lastCheckupDate;

  HealthRecordDto({
    required this.id,
    required this.petId,
    required this.lastCheckupDate,
  });

  factory HealthRecordDto.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$HealthRecordDtoToJson(this);

  HealthRecordEntity toEntity() => HealthRecordEntity(
        id: id,
        petId: petId,
        lastCheckupDate: lastCheckupDate,
      );

  static HealthRecordDto fromEntity(HealthRecordEntity entity) =>
      HealthRecordDto(
        id: entity.id,
        petId: entity.petId,
        lastCheckupDate: entity.lastCheckupDate,
      );
}

@JsonSerializable()
class MedicalHistoryDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'health_record_id')
  final String healthRecordId;
  final String condition;
  @JsonKey(name: 'treatment_date')
  final String treatmentDate;

  MedicalHistoryDto({
    required this.id,
    required this.healthRecordId,
    required this.condition,
    required this.treatmentDate,
  });

  factory MedicalHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalHistoryDtoToJson(this);

  MedicalHistoryEntity toEntity() => MedicalHistoryEntity(
        id: id,
        healthRecordId: healthRecordId,
        condition: condition,
        treatmentDate: treatmentDate,
      );

  static MedicalHistoryDto fromEntity(MedicalHistoryEntity entity) =>
      MedicalHistoryDto(
        id: entity.id,
        healthRecordId: entity.healthRecordId,
        condition: entity.condition,
        treatmentDate: entity.treatmentDate,
      );
}

@JsonSerializable()
class SpecialNeedsDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'health_record_id')
  final String healthRecordId;
  @JsonKey(name: 'special_need')
  final String specialNeed;

  SpecialNeedsDto({
    required this.id,
    required this.healthRecordId,
    required this.specialNeed,
  });

  factory SpecialNeedsDto.fromJson(Map<String, dynamic> json) =>
      _$SpecialNeedsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SpecialNeedsDtoToJson(this);

  SpecialNeedsEntity toEntity() => SpecialNeedsEntity(
        id: id,
        healthRecordId: healthRecordId,
        specialNeed: specialNeed,
      );

  static SpecialNeedsDto fromEntity(SpecialNeedsEntity entity) =>
      SpecialNeedsDto(
        id: entity.id,
        healthRecordId: entity.healthRecordId,
        specialNeed: entity.specialNeed,
      );
}

@JsonSerializable()
class VaccinationDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'health_record_id')
  final String healthRecordId;
  @JsonKey(name: 'vaccine_name')
  final String vaccineName;
  @JsonKey(name: 'vaccination_date')
  final String vaccinationDate;

  VaccinationDto({
    required this.id,
    required this.healthRecordId,
    required this.vaccineName,
    required this.vaccinationDate,
  });

  factory VaccinationDto.fromJson(Map<String, dynamic> json) =>
      _$VaccinationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VaccinationDtoToJson(this);

  VaccinationEntity toEntity() => VaccinationEntity(
        id: id,
        healthRecordId: healthRecordId,
        vaccineName: vaccineName,
        vaccinationDate: vaccinationDate,
      );

  static VaccinationDto fromEntity(VaccinationEntity entity) =>
      VaccinationDto(
        id: entity.id,
        healthRecordId: entity.healthRecordId,
        vaccineName: entity.vaccineName,
        vaccinationDate: entity.vaccinationDate,
      );
}
