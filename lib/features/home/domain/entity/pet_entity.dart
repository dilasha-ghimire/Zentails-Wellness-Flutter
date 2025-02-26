import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String id;
  final String name;
  final String age;
  final String breed;
  final bool availability;
  final String chargePerHour;
  final String? description;
  final String? image;

  const PetEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.availability,
    required this.chargePerHour,
    this.description,
    this.image,
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
      ];
}
