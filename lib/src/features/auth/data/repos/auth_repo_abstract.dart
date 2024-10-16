import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';

abstract class AuthRepoAbstract {
  Future<Either<ErrorModel, RegisterResponse>> register({
    required String email,
    required String name,
    required String admincode,
    required String password,
    required String passwordConfirmation,
    required String role,
  });

  Future<Either<ErrorModel, LoginResponse>> login({
    required String email,
    required String password,
  });
  Future<Either<ErrorModel, VerifyEmailResponse>> verifyEmail(
      {required String email, required String code});
}
