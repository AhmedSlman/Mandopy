import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/data/api/dio_consumer.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_abstract.dart';
import 'package:mandopy/src/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:mandopy/src/features/auth/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepoAbstract>(() => AuthRepoImplementation(
        api: getIt<ApiConsumer>(),
      ));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepoAbstract>()));
}
