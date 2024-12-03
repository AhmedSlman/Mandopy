// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/home/data/models/notification_model.dart';
import 'package:mandopy/src/features/home/data/repos/notifictations/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepoAbstract notificationRepo;
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  Future<void> getNotification() async {
    emit(NotificationLoading());

    final result = await notificationRepo.getNotifications();

    result.fold(
      (error) => emit(NotificationError(error)),
      (notificationResponse) {
        emit(NotificationLoaded(notificationResponse));
      },
    );
  }
}
