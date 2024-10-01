import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/home/presentation/widgets/notification_card_widget.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList(
      {super.key,
      required this.notifications,
      required this.address,
      required this.time});
  final List<String> notifications;
  final String address;
  final String time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotoficationCardWidget(
            notification: notifications[index],
            address: address,
            time: time,
          );
        },
      ),
    );
  }
}
