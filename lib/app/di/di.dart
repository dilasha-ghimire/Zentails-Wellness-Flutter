import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zentails_wellness/core/network/api_service.dart';
import 'package:zentails_wellness/core/network/hive_service.dart';
import 'package:zentails_wellness/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:zentails_wellness/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:zentails_wellness/features/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:zentails_wellness/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/login_usecase.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/register_usecase.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';
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
}

void _initCoreDependencies() {
  // Register HiveService
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

void _initAuthDependencies() {
  // Local data source
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // Remote data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  // Local repository
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // Remote repository
  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepository(
      authRemoteDataSource: getIt<AuthRemoteDataSource>()));

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
    () => SplashCubit(
      getIt<AuthLocalRepository>(),
      getIt<HiveService>(),
    ),
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
