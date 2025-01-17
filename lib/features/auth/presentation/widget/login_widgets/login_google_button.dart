import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Continue with Google tapped");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/google.svg',
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            "Continue with Google",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
