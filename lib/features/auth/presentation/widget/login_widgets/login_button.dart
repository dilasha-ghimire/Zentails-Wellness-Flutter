import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';

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
      onPressed: () async {
        context.read<LoginBloc>().add(LoginUserEvent(
              context: context,
              emailOrPhone: emailOrPhoneController.text,
              password: passwordController.text,
            ));
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
