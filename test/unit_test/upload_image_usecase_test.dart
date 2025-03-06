import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/auth/domain/repository/auth_repository.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/upload_image_usecase.dart';

// Mock class for the AuthRepository
class MockAuthRepository extends Mock implements IAuthRepository {}

// Fake class for File to avoid real file dependency
class FakeFile extends Fake implements File {}

void main() {
  // Declare variables for the use case and mock repository
  late UploadImageUsecase uploadImageUsecase;
  late MockAuthRepository mockAuthRepository;
  // ignore: unused_local_variable
  late File testFile;

  // Register fallback values before all tests
  setUpAll(() {
    registerFallbackValue(FakeFile()); // Register FakeFile for Mocktail
  });

  // Initialize before each test
  setUp(() {
    mockAuthRepository = MockAuthRepository(); // Create mock instance
    uploadImageUsecase =
        UploadImageUsecase(mockAuthRepository); // Inject mock into use case
    testFile = FakeFile(); // Use FakeFile instead of real File
  });

  // Test data
  const testImageUrl = "https://example.com/uploaded-image.jpg";
  final testParams = UploadImageParams(file: FakeFile());

  // ====================================== SUCCESS TEST ======================================

  test("should return image URL when upload is successful", () async {
    // Arrange: Stub the repository method to return a Right (successful result)
    when(() => mockAuthRepository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right(testImageUrl));

    // Act: Call the use case
    final result = await uploadImageUsecase(testParams);

    // Assert: Verify the result is successful (Right(imageUrl))
    expect(result, equals(const Right(testImageUrl)));
    verify(() => mockAuthRepository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  // ====================================== FAILURE TEST ======================================

  test("should return failure when upload fails", () async {
    // Arrange: Stub the repository method to return a Left (failure result)
    final failure = ApiFailure(500, message: "Upload failed");
    when(() => mockAuthRepository.uploadProfilePicture(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case
    final result = await uploadImageUsecase(testParams);

    // Assert: Verify the result is the expected failure
    expect(result, equals(Left(failure)));
    verify(() => mockAuthRepository.uploadProfilePicture(any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
