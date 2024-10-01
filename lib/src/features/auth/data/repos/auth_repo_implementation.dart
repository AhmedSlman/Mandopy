import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/core/errors/exceptions.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_abstract.dart';

class AuthRepoImplementation implements AuthRepoAbstract {
  final ApiConsumer api;

  AuthRepoImplementation({required this.api});
  @override
  Future<Either<ErrorModel, RegisterResponse>> register({
    required String email,
    required String name,
    required String admincode,
    required String password,
    required String passwordConfirmation,
    required String role,
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
          'admin_code': admincode,
          'role': role,
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
      return Right(userResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
