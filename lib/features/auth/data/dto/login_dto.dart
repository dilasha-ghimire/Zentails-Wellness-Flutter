import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  final String token;
  final UserDto user;

  AuthResponseDto({required this.token, required this.user});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  @JsonKey(name: 'contact_number')
  final String contactNumber;
  final String address;

  UserDto({
    required this.id,
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.address,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
