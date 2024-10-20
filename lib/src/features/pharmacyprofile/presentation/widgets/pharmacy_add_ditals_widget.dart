
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_text_form_field.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class PharmacyAddDetailsWidget extends StatelessWidget {
  PharmacyAddDetailsWidget(
      {super.key,
      required this.details,
      required this.onPressed,
      this.noteController});
  TextEditingController? noteController = TextEditingController();
  final String details;
  final VoidCallback onPressed;

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
            details,
            style: AppStyles.s20.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          CustomTextFormField(
            hintText: AppStrings.addYourDetails,
            maxLines: 2,
            controller: noteController,
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
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
