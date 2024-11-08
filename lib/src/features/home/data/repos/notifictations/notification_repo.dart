import 'package:dartz/dartz.dart';
import 'package:mandopy/src/features/home/data/models/notification_model.dart';

import '../../../../../../core/errors/error_model.dart';

abstract class NotificationRepoAbstract {
  Future<Either<ErrorModel, NotificationModel>> getNotifications();
}
