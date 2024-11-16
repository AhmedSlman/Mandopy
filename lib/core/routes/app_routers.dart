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
import 'package:mandopy/src/features/dailyPlane/data/repo/visitRepo/vistit_repo.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/views/add_daily_plan_view.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/views/daily_plane_view.dart';
import 'package:mandopy/src/features/home/presentation/view/home_view.dart';
import 'package:mandopy/src/features/prizes/presentation/views/prizes_view.dart';
import 'package:mandopy/src/features/profile/presentation/views/edit_profile_view.dart';

import 'package:mandopy/src/features/reports/presentation/views/resports_view.dart';
import 'package:mandopy/src/nav_bar.dart';

import '../../src/features/dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import '../../src/features/doctorprofile/presentation/views/doctor_profile_view.dart';
import '../../src/features/intro/presentation/splash_view.dart';
import '../../src/features/pharmacyprofile/presentation/views/pharmacy_profile_view.dart';
import '../../src/features/profile/presentation/views/profile_view.dart';

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
      path: RouterNames.navigatiomBarButton,
      builder: (context, state) => const NavigationBarButton(),
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
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const ForgetPasswordView(),
      ),
    ),
    GoRoute(
      path: RouterNames.resetPassword,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const ResetPasswordView(),
      ),
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
      path: RouterNames.addDailyPlan,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<VisitCubit>(),
        child: const AddDailyPlanView(),
      ),
    ),
    GoRoute(
      path: RouterNames.doctorProfile,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        final doctorId = extra['doctorId'] ?? '';
        final visitId = extra['visitId'] ?? '';

        return DoctorProfileView(
          doctorId: doctorId,
          visitId: visitId,
        );
      },
    ),
    GoRoute(
      path: RouterNames.pharmacyProfile,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        final pharmacyId = extra['pharmacyId'] ?? '';
        final visitId = extra['visitId'] ?? '';

        return BlocProvider(
          create: (context) => getIt<VisitCubit>(),
          child: PharmacyProfileView(
            pharmacyId: pharmacyId,
            visitId: visitId,
          ),
        );
      },
    ),
    GoRoute(
      path: RouterNames.reportsView,
      builder: (context, state) => const ReportsView(),
    ),
    GoRoute(
      path: RouterNames.prizesView,
      builder: (context, state) => const PrizesView(),
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
    GoRoute(
      path: RouterNames.profileView,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: RouterNames.editProfileView,
      builder: (context, state) => const EditProfileView(),
    ),
  ],
);
