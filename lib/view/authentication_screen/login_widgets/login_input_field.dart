import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const LoginInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
    );
  }
}
