import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/number_of_visit_row.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/visit_item_row_widget.dart';

class VisitCardWidget extends StatelessWidget {
  final String visitNumber;
  final String nameOfGoal;
  final String address;
  final String time;

  final String item;
  final bool isPharmacy;
  final bool isCompleated;

  const VisitCardWidget({
    super.key,
    required this.visitNumber,
    required this.nameOfGoal,
    required this.address,
    required this.time,
    required this.item,
    this.isPharmacy = true,
    required this.isCompleated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 16.h),
      child: Container(
          height: 262.82.h,
          width: 389.w,
          decoration: BoxDecoration(
            color: isPharmacy ? AppColors.dailyPlaneItem : AppColors.yellow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NumberOfVisitRow(
                  visitNumber: visitNumber,
                ),
                VisitItemRowWidget(
                  title: nameOfGoal,
                  icon: Icons.local_pharmacy_rounded,
                ),
                VisitItemRowWidget(
                  title: address,
                  icon: Icons.location_pin,
                ),
                VisitItemRowWidget(
                  title: item,
                  icon: Icons.medical_services_rounded,
                ),
                VisitItemRowWidget(
                  title: time,
                  icon: Icons.timer_rounded,
                ),
                isCompleated
                    ? const VisitItemRowWidget(
                        title: "انتهت الساعة 3:20 AM ",
                        icon: Icons.done_rounded,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            height: 30.h,
                            width: 100.w,
                            text: 'بدء الزياره',
                            textStyle:
                                AppStyles.s12.copyWith(color: AppColors.white),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          CustomButton(
                            height: 30.h,
                            width: 100.w,
                            backgroundColor: AppColors.accentColor,
                            text: 'انهاء الزياره',
                            textStyle:
                                AppStyles.s12.copyWith(color: AppColors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
              ],
            ),
          )),
    );
  }
}
