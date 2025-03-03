import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_details_datasource.dart';
import 'package:zentails_wellness/features/home/data/dto/pet_details_dto.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';

class PetDetailsRemoteDataSource implements IPetDetailsDataSource {
  final Dio _dio;
  final SharedPreferencesService _sharedPreferencesService;

  PetDetailsRemoteDataSource(this._dio, this._sharedPreferencesService);

  @override
  Future<PetDetailsEntity> fetchPetDetails(String petId) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      Response response = await _dio.get(
        '${ApiEndpoints.getPetById}/$petId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return PetDetailsDto.fromJson(response.data).toEntity();
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
