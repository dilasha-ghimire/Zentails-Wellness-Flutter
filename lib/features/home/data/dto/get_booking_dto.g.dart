// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookingDTO _$GetBookingDTOFromJson(Map<String, dynamic> json) =>
    GetBookingDTO(
      id: json['_id'] as String,
      date: json['date'] as String,
      startTime: (json['start_time'] as num).toInt(),
      endTime: (json['end_time'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      totalCharge: (json['total_charge'] as num).toInt(),
      status: json['status'] as String,
      user: UserBookingDto.fromJson(json['user_id'] as Map<String, dynamic>),
      pet: PetBookingDto.fromJson(json['pet_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBookingDTOToJson(GetBookingDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'duration': instance.duration,
      'total_charge': instance.totalCharge,
      'status': instance.status,
      'user_id': instance.user,
      'pet_id': instance.pet,
    };

UserBookingDto _$UserBookingDtoFromJson(Map<String, dynamic> json) =>
    UserBookingDto(
      id: json['_id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String,
      address: json['address'] as String,
      profilePicture: json['profilePicture'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$UserBookingDtoToJson(UserBookingDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'contact_number': instance.contactNumber,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
      'active': instance.active,
    };

PetBookingDto _$PetBookingDtoFromJson(Map<String, dynamic> json) =>
    PetBookingDto(
      id: json['_id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      breed: json['breed'] as String,
      description: json['description'] as String,
      availability: json['availability'] as bool,
      chargePerHour: json['charge_per_hour'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$PetBookingDtoToJson(PetBookingDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'breed': instance.breed,
      'description': instance.description,
      'availability': instance.availability,
      'charge_per_hour': instance.chargePerHour,
      'image': instance.image,
    };
