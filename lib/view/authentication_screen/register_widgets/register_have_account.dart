import 'package:flutter/material.dart';
import 'package:zentails_wellness/view/authentication_screen/login_view.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginView()),
        );
      },
      child: const Text.rich(
        TextSpan(
          text: "Already have an account? ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFCF5D7),
          ),
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFCF5D7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}