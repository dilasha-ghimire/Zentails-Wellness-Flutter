import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_datasource.dart';
import 'package:zentails_wellness/features/home/data/dto/pet_dto.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';

class PetRemoteDataSource implements IPetDataSource {
  final Dio _dio;
  final SharedPreferencesService _sharedPreferencesService;

  PetRemoteDataSource(this._dio, this._sharedPreferencesService);

  @override
  Future<List<PetEntity>> fetchPets() async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      Response response = await _dio.get(
        ApiEndpoints.getPets,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> petList = response.data;
        return petList.map((json) => PetDto.fromJson(json).toEntity()).toList();
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
