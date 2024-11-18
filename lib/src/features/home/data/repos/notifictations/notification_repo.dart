import 'package:dartz/dartz.dart';
import '../../models/notification_model.dart';

import '../../../../../../core/errors/error_model.dart';

abstract class NotificationRepoAbstract {
  Future<Either<ErrorModel, NotificationModel>> getNotifications();
}
