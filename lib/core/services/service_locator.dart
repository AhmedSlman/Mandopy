import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:mandopy/src/features/doctorprofile/cubit/doctor_profile/doctor_profile_cubit.dart';
import 'package:mandopy/src/features/doctorprofile/cubit/note/note_cubit.dart';
import 'package:mandopy/src/features/doctorprofile/data/repos/doctor_repo_abstract.dart';
import 'package:mandopy/src/features/doctorprofile/data/repos/doctor_repo_implementation.dart';
import 'package:mandopy/src/features/home/cubit/notification/notification_cubit.dart';
import 'package:mandopy/src/features/home/cubit/percentage/cubit/percentage_cubit.dart';
import 'package:mandopy/src/features/home/data/repos/notifictations/notification_repo.dart';
import 'package:mandopy/src/features/home/data/repos/notifictations/notification_repo_implementation.dart';
import 'package:mandopy/src/features/home/data/repos/percentage/percentage_repo_abstract.dart';
import 'package:mandopy/src/features/home/data/repos/percentage/percentage_repo_impl.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/location/data/repo/location_repo_abstract.dart';
import 'package:mandopy/src/features/location/data/repo/location_repo_implementation.dart';
import 'package:mandopy/src/features/pharmacyprofile/cubit/pharmacy_profile_cubit.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/repos/pharmacy_repo_abstract.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/repos/pharmacy_repo_impl.dart';
import 'package:mandopy/src/features/prizes/cubit/points_cubit.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo_implemetation.dart';
import 'package:mandopy/src/features/profile/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:mandopy/src/features/profile/cubit/statistics/cubit/statistics_cubit.dart';
import 'package:mandopy/src/features/profile/cubit/user/user_cubit.dart';
import 'package:mandopy/src/features/profile/data/repos/user_repo_abstract.dart';
import 'package:mandopy/src/features/profile/data/repos/user_repo_implementation.dart';
import 'package:mandopy/src/features/reports/cubit/reports_cubit.dart';
import 'package:mandopy/src/features/reports/data/repos/reports_repo.dart';
import 'package:mandopy/src/features/reports/data/repos/reports_repo_implementation.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
      getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());

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
  getIt.registerLazySingleton<ReportsRepo>(
      () => ReportsRepoImplementation(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<NotificationRepoAbstract>(
      () => NotificationRepoImplementation(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<UserRepoAbstract>(
      () => UserRepoImplementation(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<PercentageRepoAbstract>(
      () => PercentageRepoImpl(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<PharmacyRepoAbstract>(
      () => PharmacyRepoImplementation(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<DoctorRepoAbstract>(
      () => DoctorRepoImplementation(getIt<ApiConsumer>()));

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
  getIt.registerFactory<ReportsCubit>(() => ReportsCubit(getIt<ReportsRepo>()));
  getIt.registerFactory<NotificationCubit>(
      () => NotificationCubit(getIt<NotificationRepoAbstract>()));
  getIt.registerFactory<UserCubit>(() => UserCubit(getIt<UserRepoAbstract>()));
  getIt.registerFactory<StatisticsCubit>(
      () => StatisticsCubit(getIt<UserRepoAbstract>()));
  getIt.registerFactory<PercentageCubit>(
      () => PercentageCubit(getIt<PercentageRepoAbstract>()));
  getIt.registerFactory<PharmacyProfileCubit>(
      () => PharmacyProfileCubit(getIt<PharmacyRepoAbstract>()));
  getIt.registerFactory<DoctorProfileCubit>(
      () => DoctorProfileCubit(getIt<DoctorRepoAbstract>()));
  getIt.registerFactory<EditProfileCubit>(
      () => EditProfileCubit(getIt<UserRepoAbstract>()));
  getIt.registerFactory<NoteCubit>(
      () => NoteCubit(getIt<DoctorRepoAbstract>()));
}
