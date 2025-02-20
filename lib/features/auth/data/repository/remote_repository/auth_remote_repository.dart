import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authRemoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String emailOrPhone, String password) async {
    try {
      final token =
          await _authRemoteDataSource.loginUser(emailOrPhone, password);
      await SharedPreferencesService().saveToken(token);

      return Right(token);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.updateUser(user);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(500, message: e.toString()));
    }
  }
}
