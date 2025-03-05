import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  Future<void> checkNavigation(Function(bool, bool) onNavigate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    String? token = prefs.getString('token');

    // Save isFirstLaunch as false after first check
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }

    // Pass both values to determine navigation
    onNavigate(isFirstLaunch, token != null && token.isNotEmpty);
  }
}
