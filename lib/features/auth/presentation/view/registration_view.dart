import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';

import '../widget/register_widgets/register_button.dart';
import '../widget/register_widgets/register_have_account.dart';
import '../widget/register_widgets/register_input_field.dart';

class RegistrationView extends StatelessWidget {
  RegistrationView({super.key});

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: context.read<LoginBloc>(),
                  child: LoginView(),
                ),
              ),
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
                      hintText: "Contact Number",
                      controller: contactNumberController),
                  const SizedBox(height: 20),
                  RegisterInputField(
                      hintText: "Address", controller: addressController),
                  const SizedBox(height: 20),
                  RegistrationPasswordInputField(
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  RegistrationPasswordInputField(
                    hintText: "Confirm Password",
                    controller: confirmPasswordController,
                    isPassword: true,
                  ),
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

class RegistrationPasswordInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const RegistrationPasswordInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  RegistrationPasswordInputFieldState createState() => RegistrationPasswordInputFieldState();
}

class RegistrationPasswordInputFieldState extends State<RegistrationPasswordInputField> {
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
