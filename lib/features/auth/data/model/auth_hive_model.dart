import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:zentails_wellness/app/constants/hive_table_constant.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? authId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String contactNumber;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.contactNumber,
  }) : authId = authId ?? const Uuid().v4();

  const AuthHiveModel.initial()
      : authId = '',
        fullName = '',
        email = '',
        password = '',
        address = '',
        contactNumber = '';

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      address: entity.address,
      contactNumber: entity.contactNumber,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      password: password,
      address: address,
      contactNumber: contactNumber,
    );
  }

  @override
  List<Object?> get props =>
      [authId, fullName, email, password, address, contactNumber];
}
