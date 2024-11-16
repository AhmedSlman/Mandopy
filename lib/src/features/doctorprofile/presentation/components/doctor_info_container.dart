import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import 'package:mandopy/src/features/doctorprofile/cubit/doctor_profile/doctor_profile_cubit.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../widgets/info_row.dart';

class DoctorInfocontainer extends StatelessWidget {
  const DoctorInfocontainer(
      {super.key, required this.doctorId, required this.visitId});
  final String doctorId;
  final String visitId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('جارٍ التحقق من الموقع...')),
          );
        } else if (state is LocationCheckSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is LocationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
        width: 373.w,
        height: 315.h,
        margin: EdgeInsets.only(left: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 26.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color.fromRGBO(247, 247, 247, 1),
            width: 1.h,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.h,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return const CircularProgressIndicator();
            }
            if (state is DoctorProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.doctorProfileModel.name ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.doctorProfileModel.specialization ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.doctorProfileModel.address ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.doctorProfileModel.phone ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.doctorProfileModel.details ?? 'N/A',
                  ),
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        width: 97.w,
                        height: 26.h,
                        text: 'بدء الزيارة',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed: () {
                          context
                              .read<LocationCubit>()
                              .checkDoctorLocation(doctorId);
                          context.read<VisitCubit>().startVisit(visitId);
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        backgroundColor: AppColors.accentColor,
                        width: 97.w,
                        height: 26.h,
                        text: 'انهاء الزيارة',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed: () async {
                          bool? saleMade = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("بيع المنتج"),
                                content: const Text("هل قمت ببيع المنتج"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                          if (saleMade != null) {
                            context
                                .read<VisitCubit>()
                                .endVisit(visitId, saleMade ? "1" : "0");
                          }
                        },
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
