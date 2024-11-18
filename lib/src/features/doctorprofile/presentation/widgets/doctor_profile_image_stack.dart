import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_assets.dart';

class DoctorProfileImageStack extends StatelessWidget {
  const DoctorProfileImageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Container(
            height: 153.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppAssets.doctorCover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16.w,
          top: 64.h,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () => GoRouter.of(context).pop(),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 24.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -42.h,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 83.h,
              width: 83.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8.w),
              child: Image.asset(
                AppAssets.doctorProfile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
