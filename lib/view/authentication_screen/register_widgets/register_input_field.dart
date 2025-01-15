import 'package:flutter/material.dart';

class RegisterInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const RegisterInputField({
    required this.hintText,
    required this.controller,
    super.key,
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
