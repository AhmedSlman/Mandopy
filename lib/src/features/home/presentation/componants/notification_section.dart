import 'package:flutter/material.dart';
import 'package:mandopy/src/features/home/presentation/widgets/notification_list_widget.dart';
import 'package:mandopy/src/features/home/presentation/widgets/notification_title_widget.dart';

class NotificationSection extends StatelessWidget {
  NotificationSection({super.key});
  final List<String> notifications = [
    'لديك زيارة الدكتور سعيد في العنوان الساعة 5:30 PM',
    'لديك زيارة الدكتور محمد في العنوان الساعة 4:30 PM',
    'لديك زيارة الدكتور خالد في العنوان الساعة 3:30 PM',
    'لديك زيارة الدكتور خالد في العنوان الساعة 3:30 PM',
    'لديك زيارة الدكتور خالد في العنوان الساعة 3:30 PM',
    'لديك زيارة الدكتور خالد في العنوان الساعة 3:30 PM',
    'لديك زيارة الدكتور خالد في العنوان الساعة 3:30 PM',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationTitleWidget(),
        NotificationsList(
          notifications: notifications,
          address: 'المنصورة شارع بنك مصر عماره 12 الدور الخامس',
          time: '12:00',
        ),
      ],
    );
  }
}
