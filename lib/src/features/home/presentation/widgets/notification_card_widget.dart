import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class NotoficationCardWidget extends StatelessWidget {
  const NotoficationCardWidget({
    super.key,
    required this.notification,
    // required this.address,
    // required this.time,
  });

  final String notification;
  // final String address;
  // final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.notificationCardColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    notification,
                    style: AppStyles.s12.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.done_rounded,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              // Row(
              //   children: [
              //     Text(
              //       address,
              //       style: AppStyles.s12,
              //     ),
              //     const Spacer(),
              //     Text(
              //       time,
              //       style: AppStyles.s12,
              //     ),
              //   ],
              // )
            ],
          ),
        ));
  }
}
