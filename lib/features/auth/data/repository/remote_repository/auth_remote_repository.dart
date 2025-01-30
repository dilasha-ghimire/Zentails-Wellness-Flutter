import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String emailOrPhone, String password) async {
    try {
      final token =
          await _authRemoteDataSource.loginUser(emailOrPhone, password);
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
}
