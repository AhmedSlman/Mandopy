import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/core/errors/exceptions.dart';
import 'package:mandopy/src/features/auth/data/models/forget_password_model.dart';
import 'package:mandopy/src/features/auth/data/models/reset_password_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_abstract.dart';
import 'package:path/path.dart' as path;

class AuthRepoImplementation implements AuthRepoAbstract {
  final ApiConsumer api;

  AuthRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, RegisterResponse>> register({
    required String email,
    required String name,
    required String admincode,
    required String password,
    required String passwordConfirmation,
    required String role,
    File? image,
  }) async {
    try {
      final response = await api.post(
        "register",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        data: {
          'email': email,
          'name': name,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'supervisor_code': admincode,
          'role': role,
          if (image != null)
            'image': await MultipartFile.fromFile(image.path,
                filename: path.basename(image.path)),
        },
        isFormData: true,
      );
      final userResponse = RegisterResponse.fromJson(response);
      return Right(userResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        "login",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        data: {
          'email': email,
          'password': password,
        },
        isFormData: true,
      );
      final userResponse = LoginResponse.fromJson(response);
      CacheHelper.saveToken(value: userResponse.token);
      CacheHelper.saveData(key: 'role', value: userResponse.user.role);
      CacheHelper.saveData(key: 'name', value: userResponse.user.name);
      CacheHelper.saveData(key: 'email', value: userResponse.user.email);
      CacheHelper.saveData(key: 'image', value: userResponse.user.image);

      return Right(userResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, VerifyEmailResponse>> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await api.post(
        "verify-email",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        data: {
          'email': email,
          'verification_code': code,
        },
        isFormData: true,
      );
      final userResponse = VerifyEmailResponse.fromJson(response);

      return Right(userResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, ForgetPasswordModel>> forgetPassword(
      {required String email}) async {
    try {
      final response = await api.post(
        "forgot-password",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        data: {
          'email': email,
        },
        isFormData: true,
      );
      final forgetPasswordResponse = ForgetPasswordModel.fromJson(response);
      return Right(forgetPasswordResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, ResetPasswordModel>> resetPassword(
      {required String email,
      required String password,
      required String passwordConfirmation,
      required String code}) async {
    try {
      final response = await api.post(
        "reset-password",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json'
        },
        data: {
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'code': code,
        },
        isFormData: true,
      );
      final resetPasswordResponse = ResetPasswordModel.fromJson(response);
      return Right(resetPasswordResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
