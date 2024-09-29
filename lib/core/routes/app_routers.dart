import 'package:go_router/go_router.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/src/features/auth/presentation/views/forget_password.dart';
import 'package:mandopy/src/features/auth/presentation/views/login_view.dart';
import 'package:mandopy/src/features/auth/presentation/views/otp_code.dart';
import 'package:mandopy/src/features/auth/presentation/views/reset_password.dart';
import 'package:mandopy/src/features/auth/presentation/views/sigin_up_view.dart';
import 'package:mandopy/src/splach.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouterNames.signup,
      builder: (context, state) => const SiginUpView(),
    ),
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: RouterNames.forgetPassword,
      builder: (context, state) => const ForgetPasswordView(),
    ),
    GoRoute(
      path: RouterNames.resetPassword,
      builder: (context, state) => const ResetPasswordView(),
    ),
    GoRoute(
      path: RouterNames.otp,
      builder: (context, state) => OtpCodeView(),
    ),
  ],
);
