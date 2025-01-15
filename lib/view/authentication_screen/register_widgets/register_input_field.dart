import 'package:flutter/material.dart';

class RegisterInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const RegisterInputField({
    required this.hintText,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFFCF5D7)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFCF5D7)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFCF5D7)),
        ),
      ),
    );
  }
}
