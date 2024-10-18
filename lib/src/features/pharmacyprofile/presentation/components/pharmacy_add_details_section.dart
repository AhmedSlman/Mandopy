import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

class PharmacyAddDetailsSection extends StatelessWidget {
  const PharmacyAddDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.details,
            style: AppStyles.s20.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          const CustomTextFormField(
            hintText: AppStrings.addYourDetails,
            maxLines: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomButton(
              borderRadius: BorderRadius.circular(
                2,
              ),
              width: 143.w,
              height: 28.h,
              text: AppStrings.saveDetails,
              textStyle: AppStyles.s14.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
