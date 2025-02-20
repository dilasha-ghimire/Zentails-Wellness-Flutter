import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/shared_prefs/shared_preferences_service.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_current_user_usecase.dart';
import 'package:zentails_wellness/features/home/domain/use_case/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadImageUsecase _uploadImageUsecase;
  final GetCurrentUserUseCase _getCurrentUserUsecase;
  final UpdateUserUseCase _updateUserUsecase;

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
        (l) => emit(state.copyWith(isLoading: false)),
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
        (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
          emit(state.copyWith(
              isLoading: false, isSuccess: true, profilePicture: r));
        },
      );
    });

    // Handle update user
    on<UpdateUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final params = UpdateUserParams(
        fullName: event.fullName,
        email: event.email,
        contactNumber: event.contactNumber,
        address: event.address,
        profilePicture: state.profilePicture,
      );

      final result = await _updateUserUsecase.call(params);

      result.fold(
        (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            reloadData: true,
          ));
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
