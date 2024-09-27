import 'package:go_router/go_router.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/src/splach.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouterNames.splash,
      builder: (context, state) => const SplashView(),
    ),
  ],
);
