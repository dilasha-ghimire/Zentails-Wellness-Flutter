import 'package:flutter/material.dart';

// awesome_snackbar_content: ^0.1.5

showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? const Color.fromARGB(255, 85, 24, 13),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
