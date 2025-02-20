import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';

class GetCurrentUserUseCase implements UseCaseWithoutParams<AuthEntity> {
  final IAuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call() {
    return repository.getCurrentUser();
  }
}
