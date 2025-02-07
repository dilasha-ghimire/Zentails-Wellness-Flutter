import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/login_usecase.dart';

// Data Source Testing ensures that API calls or local database 
// queries return expected results or handle errors properly.

// Repository Testing verifies that the repository correctly processes 
// data from the data source and applies domain logic before returning it.

// Use Case Testing ensures that business logic is correctly applied, 
// orchestrating the repository and handling errors as expected.

// Mock class for the AuthRepository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Declare variables for the use case and the mock repository
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  // Initialize before each test
  setUp(() {
    mockAuthRepository = MockAuthRepository(); // Create mock instance
    loginUseCase =
        LoginUseCase(mockAuthRepository); // Inject mock into use case
  });

  // Test data
  const testParams =
      LoginParams(emailOrPhone: "test@example.com", password: "password123");
  const testToken = "fake_jwt_token";

  // ====================================== SUCCESS TEST ======================================

  test("should return token when login is successful", () async {
    // Arrange: Stub the repository method to return a Right (successful result)
    when(() => mockAuthRepository.loginUser(
            testParams.emailOrPhone, testParams.password))
        .thenAnswer((_) async => const Right(testToken));

    // Act: Call the use case
    final result = await loginUseCase(testParams);

    // Assert: Verify the result is the expected token
    expect(result, equals(const Right(testToken)));
    verify(() => mockAuthRepository.loginUser(
        testParams.emailOrPhone, testParams.password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  // ====================================== FAILURE TEST ======================================

  test("should return failure when login fails", () async {
    // Arrange: Stub the repository method to return a Left (failure result)
    final failure = ApiFailure(401, message: "Invalid credentials");
    when(() => mockAuthRepository.loginUser(
            testParams.emailOrPhone, testParams.password))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case
    final result = await loginUseCase(testParams);

    // Assert: Verify the result is the expected failure
    expect(result, equals(Left(failure)));
    verify(() => mockAuthRepository.loginUser(
        testParams.emailOrPhone, testParams.password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
