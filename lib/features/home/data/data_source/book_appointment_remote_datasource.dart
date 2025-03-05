import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/home/data/data_source/book_appointment_datasource.dart';
import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';

class AppointmentRemoteDataSource implements IAppointmentDataSource {
  final Dio _dio;
  final SharedPreferencesService _sharedPreferencesService;

  AppointmentRemoteDataSource(this._dio, this._sharedPreferencesService);

  @override
  Future<void> bookAppointment(BookAppointmentEntity appointment) async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      final sharedPrefsId = await SharedPreferencesService().getUserId();
      Response response = await _dio.post(
        ApiEndpoints.bookAppointment,
        data: {
          "date": appointment.date,
          "start_time": appointment.startTime,
          "end_time": appointment.endTime,
          "status": "scheduled",
          "user_id": sharedPrefsId,
          "pet_id": appointment.petId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Something went wrong");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
