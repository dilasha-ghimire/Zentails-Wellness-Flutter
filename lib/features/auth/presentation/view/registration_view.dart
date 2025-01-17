import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';

import '../widget/register_widgets/register_button.dart';
import '../widget/register_widgets/register_have_account.dart';
import '../widget/register_widgets/register_input_field.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            showMySnackBar(
              context: context,
              message: "Registration successful! You can now log in.",
              color: Colors.green,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: context.read<LoginBloc>(),
                  child: LoginView(), 
                ),
              ),
            );
          } else if (state.errorMessage != null) {
            showMySnackBar(
              context: context,
              message: state.errorMessage!,
              color: Colors.red,
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Join Our Family",
                    style: TextStyle(
                      fontFamily: 'GreatVibes Regular',
                      fontSize: 50,
                      color: Color(0xFFFCF5D7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RegisterInputField(
                      hintText: "Full Name", controller: fullNameController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Email", controller: emailController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Address", controller: addressController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Contact Number",
                      controller: contactNumberController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Password", controller: passwordController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController),
                  const SizedBox(height: 30),
                  RegisterButton(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    addressController: addressController,
                    contactNumberController: contactNumberController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  const SizedBox(height: 30),
                  const AlreadyHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
