import 'package:flutter/material.dart';

class ExtraText extends StatelessWidget {
  const ExtraText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Can't access your account?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)),
    );
  }
}
