import 'dart:io';

import 'package:zentails_wellness/core/network/hive_service.dart';
import 'package:zentails_wellness/features/auth/data/data_source/auth_data_source.dart';
import 'package:zentails_wellness/features/auth/data/model/auth_hive_model.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
      authId: "1",
      fullName: "",
      email: "",
      password: "",
      address: "",
      contactNumber: "",
    ));
  }

  @override
  Future<String> loginUser(String emailOrPhone, String password) async {
    try {
      await _hiveService.login(emailOrPhone, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateUser(AuthEntity user) {
    throw UnimplementedError();
  }
}
