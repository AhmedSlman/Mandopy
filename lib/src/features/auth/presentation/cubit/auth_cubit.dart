import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_abstract.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoAbstract authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final TextEditingController adminCodeController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? role;

  // Form Keys
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final GlobalKey<FormState> signInFormKey = GlobalKey();

  Future<void> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
    required String role,
    required String admincode,
  }) async {
    emit(RegisterLoadingState());

    final result = await authRepo.register(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: passwordConfirmation,
      admincode: admincode,
      role: role,
    );

    result.fold(
      (error) => emit(RegisterFailureState(errorMessage: error)),
      (userResponse) =>
          emit(RegisterSuccessState(userModel: userResponse.user)),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    final result = await authRepo.login(
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(LoginFailureState(errorMessage: error)),
      (userResponse) => emit(LoginSuccessState(userModel: userResponse.user)),
    );
  }
}
