import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zentails_wellness/view/authentication_screen/login_view.dart';
import 'package:zentails_wellness/view/onboarding_screen/onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController; // Controls the animation
  late Animation<double> _fadeAnimation; // Defines the fading effect

  @override
  void initState() {
    super.initState();

    // Lock orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync:
          this, // Ensures efficient animations by syncing with the screen refresh rate
      duration: const Duration(
          milliseconds: 1000), // Duration of the fade-out animation
    );

    // Define the fade animation (opacity from 1.0 to 0.0)
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Smooth transition effect
      ),
    );

    // Start a timer for the splash screen
    Future.delayed(const Duration(milliseconds: 4500), () async {
      if (mounted) {
        _animationController.forward().then((_) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

          if (isFirstLaunch) {
            // Navigate to onboarding if it's the first launch
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingView()),
            );
            // Set the flag to false after showing onboarding
            await prefs.setBool('isFirstLaunch', false);
          } else {
            // Navigate directly to login if not the first launch
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the AnimationController to free up resources
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5D7),
      body: FadeTransition(
        // Apply the fade animation to the splash screen content
        opacity: _fadeAnimation,
        child: Align(
          // Fix alignment, width and height of the Lottie animation
          alignment: Alignment.center,
          child: SizedBox(
            width: 350,
            height: 350,
            child: Lottie.asset(
              "assets/Lottie/welcome_scene.json",
              fit: BoxFit.contain, // Maintain the aspect ratio of the animation
            ),
          ),
        ),
      ),
    );
  }
}
