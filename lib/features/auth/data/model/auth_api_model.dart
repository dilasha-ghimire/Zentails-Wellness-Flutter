import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  final String? password;
  final String address;
  @JsonKey(name: 'contact_number')
  final String contactNumber;

  const AuthApiModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.contactNumber,
  });

  //fromJson and toJson automatically created using g.dart file
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      address: entity.address,
      contactNumber: entity.contactNumber,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      authId: id,
      fullName: fullName,
      email: email,
      password: password,
      address: address,
      contactNumber: contactNumber,
    );
  }

  @override
  List<Object?> get props =>
      [id, fullName, email, password, address, contactNumber];
}
