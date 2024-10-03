import 'package:flutter/material.dart';
import 'package:mandopy/app.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';
import 'package:mandopy/core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await getIt<CacheHelper>().init();

  runApp(const Mandopy());
}
