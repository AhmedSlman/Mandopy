import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';

class EditImageWidget extends StatelessWidget {
  const EditImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 35.w,
          child: Image.asset(
            AppAssets.profileStatic,
            width: 70.w,
            height: 70.h,
            fit: BoxFit.fill,
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
              color: const Color.fromRGBO(
                206,
                208,
                208,
                .74,
              ),
            ),
            child: Icon(
              Icons.edit,
              size: 14.w,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}