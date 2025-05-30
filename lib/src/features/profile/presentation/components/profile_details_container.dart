import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/user/user_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../widgets/profile_details_info.dart';

class ProfileDetailsContainer extends StatelessWidget {
  const ProfileDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Skeletonizer(
            child: Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          );
        } else if (state is UserLoaded) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email Info
                _ProfileInfoRow(
                  icon: Icons.email_outlined,
                  title: 'البريد الالكتروني:',
                  valueWidget: Expanded(
                    child: Text(
                      state.userModel.email,
                      style: AppStyles.s14.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Divider(height: 24.h, thickness: 1, color: Colors.grey[200]),
                // Role Info
                _ProfileInfoRow(
                  icon: Icons.account_circle_outlined,
                  title: 'الدور:',
                  valueWidget: Text(
                    state.userModel.role,
                    style: AppStyles.s14.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                ),
                Divider(height: 24.h, thickness: 1, color: Colors.grey[200]),
                // Rating Info
                _ProfileInfoRow(
                  icon: Icons.star_border_outlined,
                  title: 'التقيم:',
                  valueWidget: RatingBarIndicator(
                    rating: 3.0, // Hardcoded rating as per original logic
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.h, // Adjusted size
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

// Helper widget for info rows
class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget valueWidget;

  const _ProfileInfoRow({
    required this.icon,
    required this.title,
    required this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 22.w),
        SizedBox(width: 12.w),
        Text(
          title,
          style: AppStyles.s14
              .copyWith(color: Colors.grey[700], fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 12.w), // Spacing between title and value
        valueWidget,
      ],
    );
  }
}
