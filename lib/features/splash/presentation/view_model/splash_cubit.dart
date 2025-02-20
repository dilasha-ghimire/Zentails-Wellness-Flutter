import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zentails_wellness/features/auth/data/repository/remote_repository/auth_remote_repository.dart';

class SplashCubit extends Cubit<bool> {
  final AuthRemoteRepository authRemoteRepository;

  SplashCubit(this.authRemoteRepository) : super(true);

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    emit(isFirstLaunch);
  }
}
