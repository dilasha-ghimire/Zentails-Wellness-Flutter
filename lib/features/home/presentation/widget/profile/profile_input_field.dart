import 'package:flutter/material.dart';

class ProfileInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const ProfileInputField({
    required this.hintText,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF5D4037)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFF5D4037)), // Change to a contrasting color
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide:
              const BorderSide(color: Color(0xFF5D4037)), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide:
              const BorderSide(color: Color(0xFF5D4037)), // Border color
        ),
      ),
    );
  }
}
