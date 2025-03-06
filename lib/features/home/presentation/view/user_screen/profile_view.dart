import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/profile/profile_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/widget/profile/profile_input_field.dart';
import 'package:zentails_wellness/features/sensors/presentation/view_model/bloc/sensor_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadCurrentUser(context: context));
    context.read<SensorBloc>().add(StartProximityStream());
  }

  @override
  void dispose() {
    context.read<SensorBloc>().add(StopProximityStream());
    super.dispose();
  }

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
        // ignore: use_build_context_synchronously
        context.read<ProfileBloc>().add(
              // ignore: use_build_context_synchronously
              UploadProfileImage(context: context, file: _img!),
            );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _updateUser() async {
    final userId = await SharedPreferencesService().getUserId();
    if (userId != null) {
      // ignore: use_build_context_synchronously
      context.read<ProfileBloc>().add(UpdateUser(
            // ignore: use_build_context_synchronously
            context: context,
            authId: userId,
            fullName: _nameController.text,
            email: _emailController.text,
            contactNumber: _contactController.text,
            address: _addressController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isTablet = constraints.maxWidth > 600;
      double fontSize = isTablet ? 45.0 : 40.0;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isTablet ? 100 : 90),
          child: Padding(
            padding: EdgeInsets.only(top: isTablet ? 40.0 : 30.0),
            child: AppBar(
              title: Text(
                "Your Details",
                style: TextStyle(
                  fontFamily: 'GreatVibes Regular',
                  color: Color(0xFF5D4037),
                  fontSize: fontSize,
                ),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.reloadData) {
              context
                  .read<ProfileBloc>()
                  .add(LoadCurrentUser(context: context));
              context.read<ProfileBloc>().add(UpdateUserState());
            }
          },
          child: BlocListener<SensorBloc, SensorState>(
            listener: (context, state) {
              if (state is ProximityStateChanged && state.proximityDetected) {
                context.read<ProfileBloc>().add(Logout());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (!state.isLoading) {
                  _nameController.text = state.fullName;
                  _emailController.text = state.email;
                  _contactController.text = state.contactNumber;
                  _addressController.text = state.address;
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        style: TextStyle(
                                            color: Color(0xFFFCF5D7))),
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
                          radius: isTablet ? 110 : 70,
                          backgroundColor: const Color(0xFF5D4037),
                          backgroundImage: NetworkImage(
                              '${ApiEndpoints.imageUrlForUser}${state.profilePicture}'),
                          child: state.profilePicture == null
                              ? Icon(
                                  Icons.person,
                                  size: isTablet ? 110 : 80,
                                  color: Color(0xFFFCF5D7),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: isTablet ? 40 : 30),
                      ProfileInputField(
                        hintText: "Full Name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      ProfileInputField(
                        hintText: "Email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      ProfileInputField(
                        hintText: "Contact Number",
                        controller: _contactController,
                      ),
                      const SizedBox(height: 10),
                      ProfileInputField(
                        hintText: "Address",
                        controller: _addressController,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updateUser,
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
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ProfileBloc>().add(Logout());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 25),
                            foregroundColor: const Color(0xFFFCF5D7),
                            backgroundColor:
                                const Color.fromARGB(255, 99, 34, 14),
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
