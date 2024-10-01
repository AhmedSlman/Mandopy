part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {
  final UserModel userModel;

  RegisterSuccessState({required this.userModel});
}

final class RegisterFailureState extends AuthState {
  final ErrorModel errorMessage;

  RegisterFailureState({required this.errorMessage});
}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {
  final UserModel userModel;

  LoginSuccessState({required this.userModel});
}

final class LoginFailureState extends AuthState {
  final ErrorModel errorMessage;

  LoginFailureState({required this.errorMessage});
}
