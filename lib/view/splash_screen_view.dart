import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zentails_wellness/view/login_page_view.dart';

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
    Future.delayed(const Duration(milliseconds: 4500), () {
      // Ensures the widget is still mounted (not disposed)
      if (mounted) {
        // Play the fade-out animation, then navigate to the next screen
        _animationController.forward().then((_) {
          Navigator.pushReplacement(
            context, // Current navigation context
            MaterialPageRoute(
                builder: (context) =>
                    const LoginPage()), // Navigate to LoginPage
          );
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
