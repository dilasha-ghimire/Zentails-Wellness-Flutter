import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/register_usecase.dart';

// Data Source Testing ensures that API calls or local database 
// queries return expected results or handle errors properly.

// Repository Testing verifies that the repository correctly processes 
// data from the data source and applies domain logic before returning it.

// Use Case Testing ensures that business logic is correctly applied, 
// orchestrating the repository and handling errors as expected.

// Mock class for the AuthRepository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Declare variables for the use case and mock repository
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  // Initialize before each test
  setUp(() {
    mockAuthRepository = MockAuthRepository(); // Create mock instance
    registerUseCase =
        RegisterUseCase(mockAuthRepository); // Inject mock into use case
  });

  // Test data
  const testParams = RegisterParams(
    fullName: "Test User",
    email: "test@example.com",
    address: "123 Test Street",
    contactNumber: "1234567890",
    password: "password123",
    profilePicture: "profile.jpg",
  );

  final testAuthEntity = AuthEntity(
    fullName: testParams.fullName,
    email: testParams.email,
    address: testParams.address,
    contactNumber: testParams.contactNumber,
    password: testParams.password,
    profilePicture: testParams.profilePicture,
  );

  // ====================================== SUCCESS TEST ======================================

  test("should complete successfully when registration is successful",
      () async {
    // Arrange: Stub the repository method to return a Right (successful result)
    when(() => mockAuthRepository.registerUser(testAuthEntity))
        .thenAnswer((_) async => const Right(null));

    // Act: Call the use case
    final result = await registerUseCase(testParams);

    // Assert: Verify the result is successful (Right(null) means success)
    expect(result, equals(const Right(null)));
    verify(() => mockAuthRepository.registerUser(testAuthEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  // ====================================== FAILURE TEST ======================================

  test("should return failure when registration fails", () async {
    // Arrange: Stub the repository method to return a Left (failure result)
    final failure = ApiFailure(400, message: "Email already exists");
    when(() => mockAuthRepository.registerUser(testAuthEntity))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case
    final result = await registerUseCase(testParams);

    // Assert: Verify the result is the expected failure
    expect(result, equals(Left(failure)));
    verify(() => mockAuthRepository.registerUser(testAuthEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
