import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view/registration_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('registerButton'),
      onTap: () {
        context.read<LoginBloc>().add(
              NavigateRegisterEvent(
                destination: RegistrationView(),
                context: context,
              ),
            );
      },
      child: const Text.rich(
        TextSpan(
          text: "Ready to join our family? ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFCF5D7),
          ),
          children: [
            TextSpan(
              text: "Sign up now!",
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