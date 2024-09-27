import 'package:go_router/go_router.dart';
import 'package:mandopy/core/routes/router_names.dart';
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
  ],
);
