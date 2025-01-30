import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/features/auth/data/data_source/auth_data_source.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String emailOrNumber, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.login, data: {
        "emailOrPhone": emailOrNumber,
        "password": password,
      });

      if (response.statusCode == 200) {
        // Extract token from response
        final token = response.data["token"];
        if (token != null) {
          return token;
        } else {
          throw Exception("Token not found in response");
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "full_name": user.fullName,
        "email": user.email,
        "contact_number": user.contactNumber,
        "address": user.address,
        "password": user.password,
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
