import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: _page(),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _lottieAnimation(),
            const SizedBox(height: 10),
            const Text(
              "Welcome!",
              style: TextStyle(
                fontFamily: 'GreatVibes',
                fontSize: 48,
                color: Color(0xFFFCF5D7),
              ),
            ),
            const SizedBox(height: 30),
            _inputField("Email or Phone Number", emailOrPhoneController),
            const SizedBox(height: 20),
            _inputField("Password", passwordController, isPassword: true),
            const SizedBox(height: 50),
            _loginBtn(),
            const SizedBox(height: 30),
            _extraText(),
            const SizedBox(height: 10),
            _signUpBtn(),
            const SizedBox(height: 30),
            _loginDivider(),
            const SizedBox(height: 20),
            _googleLoginBtn(),
          ],
        ),
      ),
    );
  }

  Widget _lottieAnimation() {
    return SizedBox(
      height: 200,
      width: 1800,
      child: Lottie.asset('assets/Lottie/login_scene.json'),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFFCF5D7)));

    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFFCF5D7)),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email or Phone: ${emailOrPhoneController.text}");
        debugPrint("Password: ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF5D4037),
        backgroundColor: const Color(0xFFFCF5D7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  Widget _extraText() {
    return const Text(
      "Can't access your account?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)),
    );
  }

  Widget _signUpBtn() {
    return GestureDetector(
      onTap: () {
        debugPrint("Sign Up tapped");
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFCF5D7),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFFFCF5D7),
        ),
      ),
    );
  }

  Widget _loginDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or else login with",
            style: TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _googleLoginBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Continue with Google tapped");
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF5D4037),
        backgroundColor: const Color(0xFFFCF5D7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
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
