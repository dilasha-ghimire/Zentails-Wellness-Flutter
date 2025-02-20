import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/auth/data/data_source/auth_data_source.dart';
import 'package:zentails_wellness/features/auth/data/model/auth_api_model.dart';
import 'package:zentails_wellness/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      final userId = await SharedPreferencesService().getUserId();
      Response response = await _dio.get('${ApiEndpoints.getById}/$userId');

      if (response.statusCode == 200) {
        return AuthApiModel.fromJson(response.data).toEntity();
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
  Future<String> loginUser(String emailOrNumber, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.login, data: {
        "emailOrPhone": emailOrNumber,
        "password": password,
      });

      if (response.statusCode == 200) {
        // Extract token from response
        final token = response.data["token"];
        final userId = response.data["user"]["_id"];
        SharedPreferencesService().saveUserId(userId);
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
        "profilePicture": user.profilePicture,
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

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data'];
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
  Future<void> updateUser(AuthEntity user) async {
    try {
      Response response =
          await _dio.put('${ApiEndpoints.updateById}/${user.authId}', data: {
        "full_name": user.fullName,
        "email": user.email,
        "contact_number": user.contactNumber,
        "address": user.address,
        "profilePicture": user.profilePicture,
      });

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
