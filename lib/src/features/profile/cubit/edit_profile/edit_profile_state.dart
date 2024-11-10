part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileLoaded extends EditProfileState {
  final ProfileUserModel userModel;

  EditProfileLoaded(this.userModel);
}

final class EditProfileError extends EditProfileState {
  final ErrorModel error;

  EditProfileError(this.error);
}
