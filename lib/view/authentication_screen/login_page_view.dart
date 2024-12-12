import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5D7),
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFCF5D7),
      ),
      body: const Center(
        child: Text(
          'Page Under Construction',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
