import 'package:flutter/material.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/app_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLogoWidget(),
      ),
    );
  }
}
