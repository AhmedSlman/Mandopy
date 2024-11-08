import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/core/errors/exceptions.dart';
import 'package:mandopy/src/features/home/data/models/notification_model.dart';
import 'package:mandopy/src/features/home/data/repos/notifictations/notification_repo.dart';

import '../../../../../../core/data/cached/cache_helper.dart';

class NotificationRepoImplementation implements NotificationRepoAbstract {
  final ApiConsumer api;
  NotificationRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, NotificationModel>> getNotifications() async {
    try {
      final token = CacheHelper.getToken();
      debugPrint("token:$token");

      final response = await api.get(
        "notifications",
      );

      final notificationResponse = NotificationModel.fromJson(response);
      return Right(notificationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
