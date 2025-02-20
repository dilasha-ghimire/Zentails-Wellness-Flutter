import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/auth/domain/use_case/upload_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UploadImageUsecase _uploadImageUsecase;

  ProfileBloc({
    required UploadImageUsecase uploadImageUsecase,
  })  : _uploadImageUsecase = uploadImageUsecase,
        super(ProfileState.initial()) {
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
  }
}
