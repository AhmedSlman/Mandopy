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

final class VerifyEmailLoadingState extends AuthState {}

final class VerifyEmailSuccessState extends AuthState {
  final String userModel;

  VerifyEmailSuccessState({required this.userModel});
}

final class VerifyEmailFailureState extends AuthState {
  final ErrorModel errorMessage;

  VerifyEmailFailureState({required this.errorMessage});
}

final class ForgetPasswordLoadingState extends AuthState {}

final class ForgetPasswordSuccessState extends AuthState {
  final ForgetPasswordModel forgetPasswordModel;

  ForgetPasswordSuccessState({required this.forgetPasswordModel});
}

final class ForgetPasswordFailureState extends AuthState {
  final ErrorModel errorMessage;

  ForgetPasswordFailureState({required this.errorMessage});
}

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {
  final ResetPasswordModel resetPasswordModel;

  ResetPasswordSuccessState({required this.resetPasswordModel});
}

final class ResetPasswordFailureState extends AuthState {
  final ErrorModel errorMessage;

  ResetPasswordFailureState({required this.errorMessage});
}
final class LogoutLoadingState extends AuthState {}

final class LogoutSuccessState extends AuthState {
  final LogoutModel logoutModel;

  LogoutSuccessState({required this.logoutModel});
}

final class LogoutFailureState extends AuthState {
  final ErrorModel errorMessage;

  LogoutFailureState({required this.errorMessage});
}
