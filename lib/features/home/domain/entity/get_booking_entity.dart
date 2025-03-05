import 'package:equatable/equatable.dart';

class TherapyBookingEntity extends Equatable {
  final String id;
  final String date;
  final int startTime;
  final int endTime;
  final int duration;
  final int totalCharge;
  final String status;
  final UserBookingEntity userId;
  final PetBookingEntity petId;

  const TherapyBookingEntity({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.totalCharge,
    required this.status,
    required this.userId,
    required this.petId,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        startTime,
        endTime,
        duration,
        totalCharge,
        status,
        userId,
        petId,
      ];
}

class UserBookingEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String contactNumber;
  final String address;
  final String profilePicture;
  final bool active;

  const UserBookingEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.profilePicture,
    required this.active,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        contactNumber,
        address,
        profilePicture,
        active,
      ];
}

class PetBookingEntity extends Equatable {
  final String id;
  final String name;
  final String age;
  final String breed;
  final String description;
  final bool availability;
  final String chargePerHour;
  final String image;

  const PetBookingEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.description,
    required this.availability,
    required this.chargePerHour,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        breed,
        description,
        availability,
        chargePerHour,
        image,
      ];
}
