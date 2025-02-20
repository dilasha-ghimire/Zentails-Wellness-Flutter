import 'package:dartz/dartz.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';
import 'package:zentails_wellness/app/usecase/usecase.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';

class UpdateUserParams {
  final String fullName;
  final String email;
  final String address;
  final String contactNumber;
  final String? profilePicture;

  const UpdateUserParams({
    required this.fullName,
    required this.email,
    required this.address,
    required this.contactNumber,
    this.profilePicture,
  });
}

class UpdateUserUseCase implements UseCaseWithParams<void, UpdateUserParams> {
  final IAuthRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    final userId = await SharedPreferencesService().getUserId();
    if (userId == null) {
      return Left(ApiFailure(400, message: "User ID not found"));
    }

    final authEntity = AuthEntity(
      authId: userId, 
      fullName: params.fullName,
      email: params.email,
      address: params.address,
      contactNumber: params.contactNumber,
      profilePicture: params.profilePicture,
    );

    return repository.updateUser(authEntity);
  }
}
