import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('registerButton'),
      onTap: () {
        context.read<RegisterBloc>().add(
              NavigateLoginEvent(
                destination: LoginView(),
                context: context,
              ),
            );
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
