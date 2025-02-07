import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

// Data Source Testing ensures that API calls or local database 
// queries return expected results or handle errors properly.

// Repository Testing verifies that the repository correctly processes 
// data from the data source and applies domain logic before returning it.

// Use Case Testing ensures that business logic is correctly applied, 
// orchestrating the repository and handling errors as expected.

// Mock classes for dependencies
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockFile extends Mock implements File {}

void main() {
  late AuthRemoteRepository repository;
  late MockAuthRemoteDataSource mockDataSource;
  // ignore: unused_local_variable
  late MockFile mockFile;

  // Setup before each test
  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRemoteRepository(authRemoteDataSource: mockDataSource);
    mockFile = MockFile();
  });

  // Test data
  const testEmail = "test@example.com";
  const testPassword = "password123";
  const testToken = "fake_jwt_token";
  final testUser = AuthEntity(
    fullName: "Test User",
    email: testEmail,
    address: "123 Test Street",
    contactNumber: "1234567890",
    password: testPassword,
    profilePicture: "profile.jpg",
  );

  // ====================================== LOGIN TEST ======================================

  group('Login', () {
    // ================================ SUCCESS TEST ================================

    test("should return token on successful login", () async {
      // Arrange: Stub the remote data source to return a token
      when(() => mockDataSource.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => testToken);

      // Act: Call the repository method
      final result = await repository.loginUser(testEmail, testPassword);

      // Assert: Verify expected output
      expect(result, equals(Right(testToken)));
      verify(() => mockDataSource.loginUser(testEmail, testPassword)).called(1);
    });

    // ================================ FAILURE TEST ================================

    test("should return failure on login failure", () async {
      // Arrange: Stub the remote data source to throw an exception
      when(() => mockDataSource.loginUser(testEmail, testPassword))
          .thenThrow(Exception("Server Error"));

      // Act: Call the repository method
      final result = await repository.loginUser(testEmail, testPassword);

      // Assert: Verify failure handling
      expect(result, isA<Left>());
      verify(() => mockDataSource.loginUser(testEmail, testPassword)).called(1);
    });
  });

  // ====================================== REGISTER TEST ======================================

  group('Register', () {
    // ================================ SUCCESS TEST ================================
    test("should return Right(null) on successful registration", () async {
      // Arrange: Stub the remote data source to return successfully
      when(() => mockDataSource.registerUser(testUser))
          .thenAnswer((_) async {});

      // Act: Call the repository method
      final result = await repository.registerUser(testUser);

      // Assert: Verify successful registration
      expect(result, equals(const Right(null)));
      verify(() => mockDataSource.registerUser(testUser)).called(1);
    });

    // ================================ FAILURE TEST ================================

    test("should return failure on registration failure", () async {
      // Arrange: Stub the remote data source to throw an exception
      when(() => mockDataSource.registerUser(testUser))
          .thenThrow(Exception("Registration failed"));

      // Act: Call the repository method
      final result = await repository.registerUser(testUser);

      // Assert: Verify failure handling
      expect(result, isA<Left>());
      verify(() => mockDataSource.registerUser(testUser)).called(1);
    });
  });
}
