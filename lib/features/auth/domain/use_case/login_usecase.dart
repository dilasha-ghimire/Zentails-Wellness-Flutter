import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String emailOrPhone;
  final String password;

  const LoginParams({
    required this.emailOrPhone,
    required this.password,
  });

  const LoginParams.initial()
      : emailOrPhone = '',
        password = '';

  @override
  List<Object> get props => [emailOrPhone, password];
}

class LoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginUser(params.emailOrPhone, params.password);
  }
}
