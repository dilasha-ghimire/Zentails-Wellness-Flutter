import 'package:flutter/material.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or else login with",
            style: TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
