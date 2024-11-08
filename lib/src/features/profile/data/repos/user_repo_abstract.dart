import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';

import '../models/statistics_model.dart';

abstract class UserRepoAbstract {
  
  Future<Either<ErrorModel, UserModel>> getUserModel();

  Future<Either<ErrorModel, StatisticsModel>> getUserStatistics();

  // Future<Either<ErrorModel, StatisticsModel>> editUserProfile(
  //   {required String name}
  // );


}
