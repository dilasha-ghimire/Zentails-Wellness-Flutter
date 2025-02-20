import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/profile/profile_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/widget/profile/profile_input_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _img;

  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
        // Trigger the Bloc event to upload the image
        // ignore: use_build_context_synchronously
        context.read<ProfileBloc>().add(
              UploadProfileImage(file: _img!),
            );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Details",
          style: TextStyle(
            fontFamily: 'GreatVibes Regular',
            color: Color(0xFF5D4037),
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                GestureDetector(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _checkCameraPermission();
                                _browseImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera,
                                  color: Color(0xFFFCF5D7)),
                              label: const Text('Camera',
                                  style: TextStyle(color: Color(0xFFFCF5D7))),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5D4037),
                                minimumSize: const Size(120, 40),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _checkCameraPermission();
                                _browseImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image,
                                  color: Color(0xFFFCF5D7)),
                              label: const Text('Gallery',
                                  style: TextStyle(color: Color(0xFFFCF5D7))),
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
                    radius: 50,
                    backgroundColor: const Color(0xFF5D4037),
                    backgroundImage: _img != null ? FileImage(_img!) : null,
                    child: _img == null
                        ? const Icon(
                            Icons.person,
                            size: 70,
                            color: Color(0xFFFCF5D7),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 50),
                ProfileInputField(
                  hintText: "Full Name",
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                ProfileInputField(
                  hintText: "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                ProfileInputField(
                  hintText: "Contact Number",
                  controller: _contactController,
                ),
                const SizedBox(height: 20),
                ProfileInputField(
                  hintText: "Address",
                  controller: _addressController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle update logic here
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 25),
                      foregroundColor: const Color(0xFFFCF5D7),
                      backgroundColor: const Color(0xFF5D4037),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
