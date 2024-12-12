import 'package:flutter/material.dart';
import 'package:zentails_wellness/view/authentication_screen/registration_view.dart';
import 'package:zentails_wellness/view/dashboard_screen/dashboard_view.dart';
import 'package:zentails_wellness/view/onboarding_screen/onboarding_view.dart';
import 'package:zentails_wellness/view/splash_screen/splash_screen_view.dart';
import 'package:zentails_wellness/view/authentication_screen/login_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingView(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationView(),
        '/homepage': (context) => const DashboardView()
      },
    );
  }
}
