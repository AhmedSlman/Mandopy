import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/report_model.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import 'rating_info.dart';
import 'report_card_info.dart';

class ReportCardWidget extends StatelessWidget {
  final int index;
  final ReportModel? reports;

  const ReportCardWidget({
    super.key,
    required this.index,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {}, // يمكن ربطها لاحقاً
          child: Column(
            children: [
              Container(
                width: 394.w,
                margin: EdgeInsets.only(left: 0, right: 0),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.13),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header مع تدرج وأيقونة دائرية
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.18),
                            AppColors.accentColor.withOpacity(0.10),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 20.w,
                            child: Icon(Icons.description_outlined,
                                color: Colors.white, size: 22.w),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'تقرير ${index + 1}',
                            style: AppStyles.s18.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 14.h),
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.person_outline,
                            iconColor: AppColors.primaryColor,
                            title: 'اسم الطبيب/ الصيدلية:',
                            value: reports?.doctorOrPharmacyName ?? 'N/A',
                          ),
                          _Divider(),
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            iconColor: Colors.blueAccent,
                            title: 'الموقع:',
                            value: reports?.address ?? 'N/A',
                          ),
                          _Divider(),
                          _InfoRow(
                            icon: Icons.calendar_today_outlined,
                            iconColor: Colors.deepPurple,
                            title: 'التاريخ:',
                            value: reports?.date ?? 'N/A',
                          ),
                          _Divider(),
                          _InfoRow(
                            icon: Icons.access_time_outlined,
                            iconColor: Colors.green,
                            title: 'الوقت:',
                            value: reports?.time ?? 'N/A',
                          ),
                          _Divider(),
                          _InfoRow(
                            icon: Icons.medical_services_outlined,
                            iconColor: Colors.teal,
                            title: 'المادة الفعالة/الدواء المسوق:',
                            value: reports?.medicationName?.join(', ') ?? 'N/A',
                          ),
                          _Divider(),
                          _InfoRow(
                            icon: Icons.timer_outlined,
                            iconColor: Colors.orange,
                            title: 'مدة الزيارة:',
                            value: 'غير متوفر',
                          ),
                          _Divider(),
                          // Notes section
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.sticky_note_2_outlined,
                                    color: AppColors.accentColor, size: 20.w),
                                SizedBox(width: 6.w),
                                Text(
                                  'الملاحظات:',
                                  style: AppStyles.s14.copyWith(
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.greyForBackground,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color:
                                      AppColors.accentColor.withOpacity(0.08)),
                            ),
                            child: Text(
                              reports?.notes ?? 'N/A',
                              style:
                                  AppStyles.s14.copyWith(color: Colors.black87),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          const RatingInfo(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  const _InfoRow(
      {required this.icon,
      required this.iconColor,
      required this.title,
      required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.13),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(5.w),
            child: Icon(icon, color: iconColor, size: 18.w),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: title + ' ',
                style: AppStyles.s14.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: AppStyles.s14.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Divider(
        color: Colors.grey[300],
        thickness: 1,
        height: 1,
      ),
    );
  }
}
