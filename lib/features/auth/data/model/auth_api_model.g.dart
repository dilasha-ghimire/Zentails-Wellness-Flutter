// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      address: json['address'] as String,
      contactNumber: json['contact_number'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'contact_number': instance.contactNumber,
    };
