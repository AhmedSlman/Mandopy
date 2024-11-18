import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/data/cached/cache_helper.dart';
import '../../../../core/utils/app_assets.dart';

import '../../../../core/routes/router_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;

  String startWidget = CacheHelper.getToken() != null
      ? RouterNames.navigatiomBarButton
      : RouterNames.login;
  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), () {
      GoRouter.of(context).go(startWidget);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(AppAssets.logo),
        ),
      ),
    );
  }
}
