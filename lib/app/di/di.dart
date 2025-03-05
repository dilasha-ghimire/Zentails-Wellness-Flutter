import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/core/network/api_service.dart';
import 'package:zentails_wellness/core/network/hive_service.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/login_usecase.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/register_usecase.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:zentails_wellness/features/home/data/data_source/book_appointment_remote_datasource.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_details_remote_datasource.dart';
import 'package:zentails_wellness/features/home/data/data_source/pet_remote_datasource.dart';
import 'package:zentails_wellness/features/home/data/repository/book_appointment_remote_repository.dart';
import 'package:zentails_wellness/features/home/data/repository/pet_details_remote_repository.dart';
import 'package:zentails_wellness/features/home/data/repository/pet_remote_repository.dart';
import 'package:zentails_wellness/features/home/domain/use_case/book_appointment_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_appointment_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_current_user_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pet_details_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pets_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/update_user_usecase.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/book_appointment/book_appointment_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/get_appointment/get_appointment_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/home/pet_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/pet_details/pet_details_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/profile/profile_bloc.dart';
import 'package:zentails_wellness/features/onboarding/domain/use_case/get_onboarding_data.dart';
import 'package:zentails_wellness/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:zentails_wellness/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core services
  _initCoreDependencies();

  // Api Service
  await _initApiService();

  // Auth dependencies
  _initAuthDependencies();

  // Onboarding dependencies
  _initOnboardingDependencies();

  // Profile dependencies
  _initProfileDependencies();

  // Home dependencies
  _initPetDependencies();

  // Appointment dependencies
  _initAppointmentDependencies();
}

void _initCoreDependencies() {
  // Register HiveService
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  getIt.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

void _initAuthDependencies() {
  // Local data source
  // getIt.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSource(getIt<HiveService>()),
  // );

  // Remote data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSource(getIt<Dio>(), getIt<SharedPreferencesService>()));

  // Local repository
  // getIt.registerLazySingleton<AuthLocalRepository>(
  //   () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  // );

  // Remote repository
  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepository(
        authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      ));

  // Use cases
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRemoteRepository>()),
  );

  // Blocs
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );

  // SplashCubit
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<AuthRemoteRepository>()),
  );
}

void _initOnboardingDependencies() {
  getIt.registerLazySingleton<GetOnboardingData>(
    () => GetOnboardingData(),
  );

  getIt.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(getIt<GetOnboardingData>()),
  );
}

void _initProfileDependencies() {
  // Use cases
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(getIt<AuthRemoteRepository>()),
  );

  // Blocs
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      getCurrentUserUsecase: getIt<GetCurrentUserUseCase>(),
      updateUserUsecase: getIt<UpdateUserUseCase>(),
    ),
  );
}

void _initPetDependencies() {
  // Data Source
  getIt.registerLazySingleton<PetRemoteDataSource>(() =>
      PetRemoteDataSource(getIt<Dio>(), getIt<SharedPreferencesService>()));

  getIt.registerLazySingleton<PetDetailsRemoteDataSource>(() =>
      PetDetailsRemoteDataSource(
          getIt<Dio>(), getIt<SharedPreferencesService>()));

  // Repository
  getIt.registerLazySingleton<PetRemoteRepository>(() => PetRemoteRepository(
        petRemoteDataSource: getIt<PetRemoteDataSource>(),
      ));

  getIt.registerLazySingleton<PetDetailsRemoteRepository>(() =>
      PetDetailsRemoteRepository(
          petDetailsRemoteDataSource: getIt<PetDetailsRemoteDataSource>()));

  // Usecase
  getIt.registerLazySingleton<GetPetsUseCase>(
      () => GetPetsUseCase(getIt<PetRemoteRepository>()));

  getIt.registerLazySingleton<GetPetDetailsUseCase>(
      () => GetPetDetailsUseCase(getIt<PetDetailsRemoteRepository>()));

  // Bloc
  getIt.registerFactory<PetBloc>(
      () => PetBloc(getPetsUseCase: getIt<GetPetsUseCase>()));

  getIt.registerFactory<PetDetailsBloc>(() =>
      PetDetailsBloc(getPetDetailsUseCase: getIt<GetPetDetailsUseCase>()));
}

void _initAppointmentDependencies() {
  // Data Source
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(() =>
      AppointmentRemoteDataSource(
          getIt<Dio>(), getIt<SharedPreferencesService>()));

  // Repository
  getIt.registerLazySingleton<AppointmentRemoteRepository>(() =>
      AppointmentRemoteRepository(
          appointmentRemoteDataSource: getIt<AppointmentRemoteDataSource>()));

  // Use case
  getIt.registerLazySingleton<BookAppointmentUseCase>(
      () => BookAppointmentUseCase(getIt<AppointmentRemoteRepository>()));

  getIt.registerLazySingleton<GetAppointmentsUseCase>(
      () => GetAppointmentsUseCase(getIt<AppointmentRemoteRepository>()));

  // Bloc
  getIt.registerFactory<BookAppointmentBloc>(() => BookAppointmentBloc(
      bookAppointmentUseCase: getIt<BookAppointmentUseCase>()));

  getIt.registerFactory<GetAppointmentBloc>(() => GetAppointmentBloc(
      getAppointmentsUseCase: getIt<GetAppointmentsUseCase>()));
}
