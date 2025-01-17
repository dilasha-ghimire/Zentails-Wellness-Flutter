import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController contactNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterButton({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.addressController,
    required this.contactNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<RegisterBloc>().add(RegisterUser(
              context: context,
              fullName: fullNameController.text,
              email: emailController.text,
              address: addressController.text,
              contactNumber: contactNumberController.text,
              password: passwordController.text,
              confirmPassword: confirmPasswordController.text,
            ));
      },
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
}
