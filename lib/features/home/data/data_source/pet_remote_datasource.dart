import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_datasource.dart';
import 'package:zentails_wellness/features/home/data/dto/pet_dto.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';

class PetRemoteDataSource implements IPetDataSource {
  final Dio _dio;

  PetRemoteDataSource(this._dio);

  @override
  Future<List<PetEntity>> fetchPets() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getPets);

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
