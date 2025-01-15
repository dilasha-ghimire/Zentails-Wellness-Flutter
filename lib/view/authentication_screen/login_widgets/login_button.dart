import 'package:flutter/material.dart';
import '../../dashboard_screen/dashboard_view.dart' as dashboard;

class LoginButton extends StatelessWidget {
  final TextEditingController emailOrPhoneController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailOrPhoneController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (emailOrPhoneController.text == 'admin' &&
            passwordController.text == 'admin') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const dashboard.DashboardView(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
