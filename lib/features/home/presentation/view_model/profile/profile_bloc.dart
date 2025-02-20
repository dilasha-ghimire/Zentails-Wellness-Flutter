import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_current_user_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadImageUsecase _uploadImageUsecase;
  final GetCurrentUserUseCase _getCurrentUserUsecase;
  final UpdateUserUseCase _updateUserUsecase;

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool _isValidContactNumber(String contactNumber) {
    return RegExp(r'^\d{10}$').hasMatch(contactNumber);
  }

  bool _areFieldsFilled(UpdateUser event) {
    return event.fullName.isNotEmpty &&
        event.email.isNotEmpty &&
        event.address.isNotEmpty &&
        event.contactNumber.isNotEmpty;
  }

  ProfileBloc({
    required UploadImageUsecase uploadImageUsecase,
    required GetCurrentUserUseCase getCurrentUserUsecase,
    required UpdateUserUseCase updateUserUsecase,
  })  : _uploadImageUsecase = uploadImageUsecase,
        _getCurrentUserUsecase = getCurrentUserUsecase,
        _updateUserUsecase = updateUserUsecase,
        super(ProfileState.initial()) {
    // Load current user
    on<LoadCurrentUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await _getCurrentUserUsecase.call();
      result.fold(
        (l) {
          emit(state.copyWith(isLoading: false));
        },
        (user) {
          emit(state.copyWith(
            isLoading: false,
            fullName: user.fullName,
            email: user.email,
            contactNumber: user.contactNumber,
            address: user.address,
            profilePicture: user.profilePicture,
          ));
        },
      );
    });

    // Handle image upload
    on<UploadProfileImage>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await _uploadImageUsecase.call(
        UploadImageParams(
          file: event.file,
        ),
      );

      result.fold(
        (l) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Image upload failed. Try again.",
          );
        },
        (r) {
          emit(state.copyWith(
              isLoading: false, isSuccess: true, profilePicture: r));
          showMySnackBar(
            context: event.context,
            message: "Click on update to save the image.",
            color: const Color.fromARGB(255, 158, 117, 40),
          );
        },
      );
    });

    // Handle update user
    on<UpdateUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      if (!_areFieldsFilled(event)) {
        showMySnackBar(
          context: event.context,
          message: "All fields must be filled.",
        );
        emit(state.copyWith(isLoading: false));
        return;
      }

      if (!_isValidEmail(event.email)) {
        showMySnackBar(
          context: event.context,
          message: "Enter a valid email address.",
        );
        emit(state.copyWith(isLoading: false));
        return;
      }

      if (!_isValidContactNumber(event.contactNumber)) {
        showMySnackBar(
          context: event.context,
          message: "Enter a valid 10-digit contact number.",
        );
        emit(state.copyWith(isLoading: false));
        return;
      }

      final params = UpdateUserParams(
        fullName: event.fullName,
        email: event.email,
        contactNumber: event.contactNumber,
        address: event.address,
        profilePicture: state.profilePicture,
      );

      final result = await _updateUserUsecase.call(params);

      result.fold(
        (l) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
        },
        (r) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            reloadData: true,
          ));
          showMySnackBar(
            context: event.context,
            message: "User data updated successfully!",
            color: Colors.green,
          );
        },
      );
    });

    on<UpdateUserState>((event, emit) {
      emit(state.copyWith(reloadData: false));
    });

    on<Logout>((event, emit) async {
      await SharedPreferencesService().removeUserIdAndToken();
      emit(state.copyWith(isSuccess: true, reloadData: true));
    });
  }
}
