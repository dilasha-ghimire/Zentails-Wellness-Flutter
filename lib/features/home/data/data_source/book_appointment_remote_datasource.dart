import 'package:dio/dio.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/home/data/data_source/book_appointment_datasource.dart';
import 'package:zentails_wellness/features/home/data/dto/get_booking_dto.dart';
import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';

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

  @override
  Future<List<TherapyBookingEntity>> getAppointmentsByUserId() async {
    try {
      String? token = await _sharedPreferencesService.getToken();
      final sharedPrefsId = await SharedPreferencesService().getUserId();

      Response response = await _dio.get(
        '${ApiEndpoints.getBookingByUserId}$sharedPrefsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<GetBookingDTO> dtoList = (response.data as List)
            .map((appointmentData) => GetBookingDTO.fromJson(appointmentData))
            .toList();

        List<TherapyBookingEntity> appointments = dtoList.map((dto) {
          return TherapyBookingEntity(
            id: dto.id,
            date: dto.date,
            startTime: dto.startTime,
            endTime: dto.endTime,
            duration: dto.duration,
            totalCharge: dto.totalCharge,
            status: dto.status,
            userId: UserBookingEntity(
              id: dto.user.id,
              fullName: dto.user.fullName,
              email: dto.user.email,
              contactNumber: dto.user.contactNumber,
              address: dto.user.address,
              profilePicture: dto.user.profilePicture,
              active: dto.user.active,
            ),
            petId: PetBookingEntity(
              id: dto.pet.id,
              name: dto.pet.name,
              age: dto.pet.age,
              breed: dto.pet.breed,
              description: dto.pet.description,
              availability: dto.pet.availability,
              chargePerHour: dto.pet.chargePerHour,
              image: dto.pet.image,
            ),
          );
        }).toList();

        return appointments;
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
