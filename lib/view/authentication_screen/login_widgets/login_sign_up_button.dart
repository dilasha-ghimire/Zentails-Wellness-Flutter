import 'package:flutter/material.dart';
import '../registration_view.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationView()),
        );
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFCF5D7),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFFFCF5D7),
        ),
      ),
    );
  }
}
