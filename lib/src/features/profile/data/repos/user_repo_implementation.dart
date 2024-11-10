import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/auth/data/models/user_model.dart';
import 'package:mandopy/src/features/profile/data/models/statistics_model.dart';
import 'package:mandopy/src/features/profile/data/repos/user_repo_abstract.dart';

import '../../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

class UserRepoImplementation implements UserRepoAbstract {
  final ApiConsumer api;

  UserRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, UserModel>> getUserModel() async {
    try {
      final response = await api.get(
        "profile",
      );

      final notificationResponse = UserModel.fromJson(response['user']);
      return Right(notificationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, StatisticsModel>> getUserStatistics() async {
    try {
      final response = await api.get(
        "profile-statistics",
      );

      final statisticsResponse = StatisticsModel.fromJson(response);
      return Right(statisticsResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, ProfileUserModel>> updateProfile(
      {required String name, String? image}) async {
    try {
      final response = await api.post('profile-update', data: {
        'name': name,
        'image': image,
      });
      final editResponse = ProfileUserModel.fromJson(response);
      return Right(editResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
