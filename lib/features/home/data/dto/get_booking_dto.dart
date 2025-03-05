import 'package:json_annotation/json_annotation.dart';

part 'get_booking_dto.g.dart';

@JsonSerializable()
class GetBookingDTO {
  @JsonKey(name: '_id')
  final String id;
  final String date;
  @JsonKey(name: 'start_time')
  final int startTime; // Assuming time is in minutes from midnight
  @JsonKey(name: 'end_time')
  final int endTime; // Assuming time is in minutes from midnight
  final int duration;
  @JsonKey(name: 'total_charge')
  final int totalCharge;
  final String status;
  @JsonKey(name: 'user_id')
  final UserBookingDto user;
  @JsonKey(name: 'pet_id')
  final PetBookingDto pet;

  GetBookingDTO({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.totalCharge,
    required this.status,
    required this.user,
    required this.pet,
  });

  factory GetBookingDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBookingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookingDTOToJson(this);
}

@JsonSerializable()
class UserBookingDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  @JsonKey(name: 'contact_number')
  final String contactNumber;
  final String address;
  @JsonKey(name: 'profilePicture')
  final String profilePicture;
  final bool active;

  UserBookingDto({
    required this.id,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.profilePicture,
    required this.active,
  });

  factory UserBookingDto.fromJson(Map<String, dynamic> json) =>
      _$UserBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserBookingDtoToJson(this);
}

@JsonSerializable()
class PetBookingDto {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String age;
  final String breed;
  final String description;
  final bool availability;
  @JsonKey(name: 'charge_per_hour')
  final String chargePerHour;
  final String image;

  PetBookingDto({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.description,
    required this.availability,
    required this.chargePerHour,
    required this.image,
  });

  factory PetBookingDto.fromJson(Map<String, dynamic> json) =>
      _$PetBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PetBookingDtoToJson(this);
}
