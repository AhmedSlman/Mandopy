import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class AddNewVisitSection extends StatelessWidget {
  const AddNewVisitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          const Text(AppStrings.addNewVisit),
          const Spacer(),
          Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
