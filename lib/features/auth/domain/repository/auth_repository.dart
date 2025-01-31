import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, String>> loginUser(
      String emailOrPhone, String password);
  Future<Either<Failure, void>> registerUser(AuthEntity user);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
