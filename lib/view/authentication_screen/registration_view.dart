import 'package:flutter/material.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                const Text(
                  "Join Our Family",
                  style: TextStyle(
                    fontFamily: 'GreatVibes',
                    fontSize: 48,
                    color: Color(0xFFFCF5D7),
                  ),
                ),
                const SizedBox(height: 50),
                _inputField("Full Name", fullNameController),
                const SizedBox(height: 20),
                _inputField("Email", emailController),
                const SizedBox(height: 20),
                _inputField("Address", addressController),
                const SizedBox(height: 20),
                _inputField("Contact Number", contactNumberController),
                const SizedBox(height: 40),
                _registerBtn(),
                const SizedBox(height: 20),
                _alreadyHaveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xFFFCF5D7)),
    );

    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFFCF5D7)),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Register button tapped");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
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
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _alreadyHaveAccount(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Text.rich(
        TextSpan(
          text: "Already have an account? ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFCF5D7),
          ),
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFCF5D7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
