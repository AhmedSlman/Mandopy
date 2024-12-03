part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserModel userModel;

  UserLoaded(this.userModel);
}

final class UserError extends UserState {
  final ErrorModel error;

  UserError(this.error);
}
