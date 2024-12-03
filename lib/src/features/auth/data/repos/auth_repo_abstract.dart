import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/errors/error_model.dart';
import '../models/forget_password_model.dart';
import '../models/logout_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_model.dart';

abstract class AuthRepoAbstract {
  Future<Either<ErrorModel, RegisterResponse>> register({
    required String email,
    required String name,
    required String admincode,
    required String password,
    required String passwordConfirmation,
    required String role,
    File? image,
  });

  Future<Either<ErrorModel, LoginResponse>> login({
    required String email,
    required String password,
  });
  Future<Either<ErrorModel, VerifyEmailResponse>> verifyEmail(
      {required String email, required String code});
  Future<Either<ErrorModel, ForgetPasswordModel>> forgetPassword(
      {required String email});
  Future<Either<ErrorModel, ResetPasswordModel>> resetPassword(
      {required String email,
      required String password,
      required String passwordConfirmation,
      required String code});
  Future<Either<ErrorModel, LogoutModel>> logout();
}
