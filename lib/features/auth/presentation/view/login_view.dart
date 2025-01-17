import 'package:flutter/material.dart';

import '../widget/login_widgets/login_button.dart';
import '../widget/login_widgets/login_divider.dart';
import '../widget/login_widgets/login_google_button.dart';
import '../widget/login_widgets/login_input_field.dart';
import '../widget/login_widgets/login_lottie_animation.dart';
import '../widget/login_widgets/login_sign_up_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LottieAnimation(),
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontFamily: 'GreatVibes Regular',
                    fontSize: 50,
                    color: Color(0xFFFCF5D7),
                  ),
                ),
                const SizedBox(height: 30),
                LoginInputField(
                  hintText: "Email or Phone Number",
                  controller: emailOrPhoneController,
                ),
                const SizedBox(height: 20),
                LoginInputField(
                  hintText: "Password",
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 50),
                LoginButton(
                  emailOrPhoneController: emailOrPhoneController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 30),
                const SignUpButton(),
                const SizedBox(height: 30),
                const LoginDivider(),
                const SizedBox(height: 20),
                const GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
