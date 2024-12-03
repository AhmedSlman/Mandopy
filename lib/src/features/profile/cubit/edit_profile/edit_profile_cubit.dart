import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../../../core/errors/error_model.dart';

import '../../data/repos/user_repo_abstract.dart';
import 'package:meta/meta.dart';

import '../../data/models/user_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepoAbstract userRepoAbstract;
  EditProfileCubit(this.userRepoAbstract) : super(EditProfileInitial());

  Future<void> updateProfile({required String name, File? image}) async {
    emit(EditProfileLoading());
    final result = await userRepoAbstract.updateProfile(
      name: name,
      image: image,
    );
    result.fold(
      (error) => emit(EditProfileError(error)),
      (editProfileResponse) => emit(
        EditProfileLoaded(editProfileResponse),
      ),
    );
  }
}
