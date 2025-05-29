// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/pharmacyprofile/cubit/pharmacy_profile_cubit.dart';
import 'package:mandopy/src/features/doctorprofile/cubit/note/note_cubit.dart';
import 'package:mandopy/src/features/pharmacyprofile/presentation/components/pharmacy_add_details_section.dart';
import 'package:mandopy/src/features/pharmacyprofile/presentation/components/pharmacy_info_container.dart';
import 'package:mandopy/src/features/pharmacyprofile/presentation/widgets/pharmacy_profile_image_stack.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class PharmacyProfileView extends StatelessWidget {
  final String pharmacyId;
  final String visitId;

  const PharmacyProfileView({
    super.key,
    required this.pharmacyId,
    required this.visitId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<PharmacyProfileCubit>()
                ..getPharmacyProfile(pharmacyId: pharmacyId),
            ),
            BlocProvider(
              create: (context) => getIt<LocationCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<NoteCubit>(),
            ),
          ],
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const PharmacyProfileImageStack(),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Hero(
                    tag: 'pharmacy_info_$pharmacyId',
                    child: PharmacyInfoContainer(
                      pharmacyId: pharmacyId,
                      visitId: visitId,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {
                    if (state is LocationLoading) {
                      // _showLoadingDialog(context);
                    } else if (state is LocationFailure) {
                      String message;
                      if (state.message.contains("إذن الموقع")) {
                        message =
                            "برجاء تفعيل إذن الموقع لاستخدام هذه الخاصية.";
                      } else {
                        message = state.message;
                      }
                      _showMessage(context, message);
                    } else if (state is LocationSuccess) {
                      _showMessage(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: 373.w,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<LocationCubit>().checkAndSaveLocation(
                                isDoctor: false, entityId: pharmacyId);
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 24.w,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20.w,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'اضغط للوصول للموقع',
                                    style: AppStyles.s14.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                Container(
                  width: 373.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            color: AppColors.primaryColor,
                            size: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'تفاصيل الزيارة',
                            style: AppStyles.s16.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      PharmacyAddDetailsSection(
                        pharmacyId: pharmacyId,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "جارٍ التحقق من الموقع...",
                  style: AppStyles.s14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 20.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: AppStyles.s14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}
