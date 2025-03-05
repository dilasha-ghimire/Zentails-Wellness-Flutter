import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zentails_wellness/app/di/di.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/home/presentation/view/dashboard_screen/dashboard_view.dart';
import 'package:zentails_wellness/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:zentails_wellness/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:zentails_wellness/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 4500));

    if (context.mounted) {
      context
          .read<SplashCubit>()
          .checkNavigation((isFirstLaunch, isAuthenticated) {
        _navigateToNextScreen(isFirstLaunch, isAuthenticated);
      });
    }
  }

  void _navigateToNextScreen(bool isFirstLaunch, bool isAuthenticated) {
    Widget nextScreen;

    if (isFirstLaunch) {
      nextScreen = BlocProvider.value(
          value: getIt<OnboardingBloc>(), child: const OnboardingView());
    } else if (isAuthenticated) {
      nextScreen = DashboardView();
    } else {
      nextScreen = LoginView();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5D7),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.width * 0.70,
            child: Lottie.asset(
              "assets/Lottie/welcome_scene.json",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
