import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';

class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String address;
  final String contactNumber;
  final String password;
  final String? profilePicture;

  const RegisterParams({
    required this.fullName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.password,
    this.profilePicture,
  });

  const RegisterParams.initial({
    required this.fullName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.password,
    this.profilePicture,
  });

  @override
  List<Object?> get props =>
      [fullName, email, address, contactNumber, password];
}

class RegisterUseCase implements UseCaseWithParams<void, RegisterParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      address: params.address,
      contactNumber: params.contactNumber,
      password: params.password,
      profilePicture: params.profilePicture,
    );
    return repository.registerUser(authEntity);
  }
}
