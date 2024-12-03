import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../auth/data/models/user_model.dart';

import '../models/statistics_model.dart';
import '../models/user_model.dart';

abstract class UserRepoAbstract {
  Future<Either<ErrorModel, UserModel>> getUserModel();

  Future<Either<ErrorModel, StatisticsModel>> getUserStatistics();

  Future<Either<ErrorModel, ProfileUserModel>> updateProfile(
      {required String name, File? image});
}
