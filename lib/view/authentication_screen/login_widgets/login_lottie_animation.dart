import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    // Display Lottie animation for visual appeal
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Lottie.asset(
          'assets/Lottie/login_scene.json'), // Path to Lottie asset
    );
  }
}
