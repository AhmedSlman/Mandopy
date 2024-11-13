import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mandopy/src/features/home/cubit/notification/notification_cubit.dart';
import 'package:mandopy/src/features/home/presentation/widgets/notification_card_widget.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    super.key,
    // required this.notifications,
    // required this.address,
    // required this.time,
  });

  // final List<String> notifications;
  // final String address;
  // final String time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is NotificationLoading,
            child: state is NotificationLoaded &&
                    (state.notificationModel.notifications?.isEmpty ?? true)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.notifications_off,
                            size: 50, color: Colors.grey),
                        SizedBox(height: 10.h),
                        Text(
                          'ليس لديك اي اشعاؤات',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state is NotificationLoaded
                        ? state.notificationModel.notifications?.length ?? 0
                        : 5,
                    itemBuilder: (context, index) {
                      if (state is NotificationLoaded) {
                        return NotoficationCardWidget(
                          notification: state.notificationModel
                                  .notifications?[index].data?.message ??
                              'N/A',
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          height: 60.h,
                          color: Colors.grey.shade300,
                        );
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
