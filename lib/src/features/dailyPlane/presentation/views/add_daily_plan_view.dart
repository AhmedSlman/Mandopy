import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import '../componats/add_daily_plan_form.dart';
import '../componats/add_daily_plan_list_view.dart';

class AddDailyPlanView extends StatelessWidget {
  const AddDailyPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: AppStrings.addDailyPlan,
              iconright: Icons.arrow_forward_ios,
              onPressedRight: () => GoRouter.of(context).pop(),
            ),
            const AddDailyPlanForm(),
            SizedBox(
              height: 10.h,
            ),
            // const AddDailyPlanListView(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomButton(
            //       width: 178.w,
            //       height: 33.h,
            //       text: 'تاكيد الخطة',
            //       onPressed: () {},
            //     ),
            //     const SizedBox(
            //       width: 14,
            //     ),
            //     CustomButton(
            //       backgroundColor: AppColors.accentColor,
            //       width: 178.w,
            //       height: 33.h,
            //       text: 'تجاهل',
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
