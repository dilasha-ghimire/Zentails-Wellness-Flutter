import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool _areFieldsFilled() {
    return fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess && _areFieldsFilled()) {
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: const Color(0xFFFCF5D7),
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera,
                                        color: Color(0xFFFCF5D7)),
                                    label: const Text('Camera',
                                        style: TextStyle(
                                            color: Color(0xFFFCF5D7))),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF5D4037),
                                      minimumSize: const Size(120, 40),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image,
                                        color: Color(0xFFFCF5D7)),
                                    label: const Text('Gallery',
                                        style: TextStyle(
                                            color: Color(0xFFFCF5D7))),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF5D4037),
                                      minimumSize: const Size(120, 40),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFFFCF5D7),
                          backgroundImage:
                              _img != null ? FileImage(_img!) : null,
                          child: _img == null
                              ? const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color(0xFF5D4037),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RegisterInputField(
                          hintText: "Full Name",
                          controller: fullNameController,
                        ),
                      ),
                    ],
                  ),
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
                  RegisterInputField(
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  RegisterInputField(
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
