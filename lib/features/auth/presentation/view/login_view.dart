import 'package:flutter/material.dart';

import '../widget/login_widgets/login_button.dart';
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
                LoginPasswordInputField(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPasswordInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const LoginPasswordInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  LoginPasswordInputFieldState createState() => LoginPasswordInputFieldState();
}

class LoginPasswordInputFieldState extends State<LoginPasswordInputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscure : false,
      style: const TextStyle(color: Color(0xFFFCF5D7)),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFFFCF5D7)),
        filled: true,
        fillColor: Color(0xFF5D4037),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFFFCF5D7),
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
