import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

// Data Source Testing ensures that API calls or local database 
// queries return expected results or handle errors properly.

// Repository Testing verifies that the repository correctly processes 
// data from the data source and applies domain logic before returning it.

// Use Case Testing ensures that business logic is correctly applied, 
// orchestrating the repository and handling errors as expected.

// Mock classes for dependencies
class MockDio extends Mock implements Dio {}

class MockFile extends Mock implements File {}

void main() {
  late AuthRemoteDataSource dataSource;
  late MockDio mockDio;
  // ignore: unused_local_variable
  late MockFile mockFile;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSource(mockDio);
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
      // Arrange: Stub the Dio HTTP client to return a mock response
      when(() => mockDio.post(ApiEndpoints.login, data: any(named: "data")))
          .thenAnswer((_) async => Response(
                data: {"token": testToken},
                statusCode: 200,
                requestOptions: RequestOptions(path: ApiEndpoints.login),
              ));

      // Act: Call the login method
      final result = await dataSource.loginUser(testEmail, testPassword);

      // Assert: Verify the expected token is returned
      expect(result, equals(testToken));
      verify(() => mockDio.post(ApiEndpoints.login, data: any(named: "data")))
          .called(1);
    });

    // ================================ FAILURE TEST ================================

    test("should throw exception on login failure", () async {
      // Arrange: Stub the Dio HTTP client to throw an exception
      when(() => mockDio.post(ApiEndpoints.login, data: any(named: "data")))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.login)));

      // Act & Assert: Verify that calling login throws an exception
      expect(
          () => dataSource.loginUser(testEmail, testPassword), throwsException);
    });
  });

  // ====================================== REGISTER TEST ======================================

  group('Register', () {
    // ================================ SUCCESS TEST ================================

    test("should complete on successful registration", () async {
      // Arrange: Stub the Dio HTTP client to return a successful response
      when(() => mockDio.post(ApiEndpoints.register, data: any(named: "data")))
          .thenAnswer((_) async => Response(
                statusCode: 201,
                requestOptions: RequestOptions(path: ApiEndpoints.register),
              ));

      // Act: Call the register method
      await dataSource.registerUser(testUser);

      // Assert: Verify the register API was called
      verify(() =>
              mockDio.post(ApiEndpoints.register, data: any(named: "data")))
          .called(1);
    });

    // ================================ FAILURE TEST ================================

    test("should throw exception on registration failure", () async {
      // Arrange: Stub the Dio HTTP client to throw an exception
      when(() => mockDio.post(ApiEndpoints.register, data: any(named: "data")))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.register)));

      // Act & Assert: Verify that calling register throws an exception
      expect(() => dataSource.registerUser(testUser), throwsException);
    });
  });
}
