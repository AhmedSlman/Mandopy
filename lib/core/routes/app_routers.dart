import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/views/forget_password.dart';
import 'package:mandopy/src/features/auth/presentation/views/login_view.dart';
import 'package:mandopy/src/features/auth/presentation/views/otp_code.dart';
import 'package:mandopy/src/features/auth/presentation/views/reset_password.dart';
import 'package:mandopy/src/features/auth/presentation/views/sigin_up_view.dart';
import 'package:mandopy/src/features/auth/presentation/views/vreify_email_view.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/views/daily_plane_view.dart';
import 'package:mandopy/src/features/home/presentation/view/home_view.dart';
import 'package:mandopy/src/splach.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouterNames.signup,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const SiginUpView(),
      ),
    ),
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const LoginView(),
      ),
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
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: RouterNames.dailyPlane,
      builder: (context, state) => const DailyPlaneView(),
    ),
    GoRoute(
      path: RouterNames.verifyEmail,
      builder: (context, state) {
        final email = state.extra is String ? state.extra as String : '';
        return BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: VerifyEmailView(
            email: email,
          ),
        );
      },
    ),
  ],
);
