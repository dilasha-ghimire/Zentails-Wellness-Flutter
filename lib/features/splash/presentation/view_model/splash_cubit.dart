import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zentails_wellness/core/network/hive_service.dart';
import 'package:zentails_wellness/features/auth/data/repository/local_repository/auth_local_repository.dart';

class SplashCubit extends Cubit<bool> {
  final AuthLocalRepository authLocalRepository;
  final HiveService hiveService;

  SplashCubit(this.authLocalRepository, this.hiveService) : super(true);

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    emit(isFirstLaunch);
  }
}
