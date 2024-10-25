import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/data/api/dio_consumer.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_abstract.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/targetsAndMedecineREpo/targets_and_medecine_repo.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/targetsAndMedecineREpo/targets_and_medecine_repo_implementation.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/visitRepo/vistit_repo.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/visitRepo/vistit_repo_implementation.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/location/data/repo/location_repo_abstract.dart';
import 'package:mandopy/src/features/location/data/repo/location_repo_implementation.dart';
import 'package:mandopy/src/features/prizes/cubit/points_cubit.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo_implemetation.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));

  // Repositories //
  getIt.registerLazySingleton<AuthRepoAbstract>(
      () => AuthRepoImplementation(getIt<ApiConsumer>()));

  getIt.registerLazySingleton<VisitRepoAbstract>(
      () => VisitRepoImplementation(getIt<ApiConsumer>()));

  getIt.registerLazySingleton<BounsRepoAbstract>(
      () => BounsRepoImplementation(getIt<ApiConsumer>()));

  getIt.registerLazySingleton<TargatsRepoAbstract>(
      () => TargetsRepoImplementation(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<LocationRepoAbstract>(
      () => LocationRepoImplementation(getIt<ApiConsumer>()));

  // Cubits //
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepoAbstract>()));
  getIt.registerFactory<PointsCubit>(
      () => PointsCubit(getIt<BounsRepoAbstract>()));
  getIt.registerFactory<VisitCubit>(
      () => VisitCubit(getIt<VisitRepoAbstract>()));
  getIt.registerFactory<TargetsCubit>(
      () => TargetsCubit(getIt<TargatsRepoAbstract>()));
  getIt.registerFactory<LocationCubit>(
      () => LocationCubit(getIt<LocationRepoAbstract>()));
}
