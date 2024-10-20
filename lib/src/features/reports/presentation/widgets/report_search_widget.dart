import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';

class ReportSearchWidget extends StatelessWidget {
  const ReportSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 50.h,
          width: 360.w,
          child: CustomTextFormField(
            hintText: 'بحث',
            suffixIcon: SvgPicture.asset(
              AppAssets.searchIcon,
              width: 12.w,
              height: 12.h,
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 42.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.greyForBackground,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: const Icon(
            Icons.menu,
          ),
        ),
      ],
    );
  }
}
