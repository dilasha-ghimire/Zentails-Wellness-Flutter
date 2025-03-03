import 'package:equatable/equatable.dart';

class PetDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String age;
  final String breed;
  final bool availability;
  final String chargePerHour;
  final String? description;
  final String? image;
  final HealthRecordEntity? healthRecord;
  final List<MedicalHistoryEntity> medicalHistory;
  final List<SpecialNeedsEntity> specialNeeds;
  final List<VaccinationEntity> vaccinations;

  const PetDetailsEntity({
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

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        breed,
        availability,
        chargePerHour,
        description,
        image,
        healthRecord,
        medicalHistory,
        specialNeeds,
        vaccinations,
      ];
}

class HealthRecordEntity extends Equatable {
  final String id;
  final String petId;
  final String lastCheckupDate;

  const HealthRecordEntity({
    required this.id,
    required this.petId,
    required this.lastCheckupDate,
  });

  @override
  List<Object?> get props => [id, petId, lastCheckupDate];
}

class MedicalHistoryEntity extends Equatable {
  final String id;
  final String healthRecordId;
  final String condition;
  final String treatmentDate;

  const MedicalHistoryEntity({
    required this.id,
    required this.healthRecordId,
    required this.condition,
    required this.treatmentDate,
  });

  @override
  List<Object?> get props => [id, healthRecordId, condition, treatmentDate];
}

class SpecialNeedsEntity extends Equatable {
  final String id;
  final String healthRecordId;
  final String specialNeed;

  const SpecialNeedsEntity({
    required this.id,
    required this.healthRecordId,
    required this.specialNeed,
  });

  @override
  List<Object?> get props => [id, healthRecordId, specialNeed];
}

class VaccinationEntity extends Equatable {
  final String id;
  final String healthRecordId;
  final String vaccineName;
  final String vaccinationDate;

  const VaccinationEntity({
    required this.id,
    required this.healthRecordId,
    required this.vaccineName,
    required this.vaccinationDate,
  });

  @override
  List<Object?> get props =>
      [id, healthRecordId, vaccineName, vaccinationDate];
}
