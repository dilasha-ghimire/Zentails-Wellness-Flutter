import 'package:flutter/material.dart';

Widget buildImageContainer(
  BuildContext context,
  Color color,
  String title,
  String subtitle,
  String imagePath, {
  bool isCircular = false,
  double? imageWidth,
  double? imageHeight,
}) {
  return SafeArea(
    child: Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isCircular
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.height * 0.45,
              height: isCircular
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                      (isCircular ? 0.3 : 0.7 * 255).toInt(),
                      0,
                      0,
                      0,
                    ),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'GreatVibes Regular',
                fontWeight: FontWeight.w500,
                fontSize: 45,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 18,
                  color: Color.fromARGB(255, 93, 71, 65),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
