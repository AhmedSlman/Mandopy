import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/router_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';

class ProfileImageAndname extends StatelessWidget {
  const ProfileImageAndname({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => GoRouter.of(context).push(RouterNames.editProfileView),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 35.w,
                child: Image.asset(
                  AppAssets.userProfile,
                  width: 70.w,
                  height: 70.h,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 14.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          'احمد محمد علي',
          style: AppStyles.s16.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
