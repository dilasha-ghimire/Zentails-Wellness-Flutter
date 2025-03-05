import 'package:flutter/material.dart';

showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  bool isTablet = screenWidth >= 600;
  double fontSize = isTablet ? 24 : 14;
  double marginHorizontal = isTablet ? screenWidth * 0.2 : screenWidth * 0.1;
  double paddingVertical = isTablet ? 20 : 16;
  double borderRadius = isTablet ? 15 : 12;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: fontSize),
      ),
      backgroundColor: color ?? const Color.fromARGB(255, 85, 24, 13),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: paddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
