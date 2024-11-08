import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/profile/cubit/user/user_cubit.dart';
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
              width: 404.w,
              height: 129.h,
              color: Colors.grey,
            ),
          );
        } else if (state is UserLoaded) {
          return Container(
            width: 365.w,
            height: 112.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: AppColors.greyForBackground,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 17.h,
                right: 17.w,
              ),
              child: Column(
                children: [
                  ProfileDetailsInfo(
                    title: 'البريد الالكتروني:',
                    value: Flexible(
                      child: Text(
                        state.userModel.email,
                        style: AppStyles.s14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ProfileDetailsInfo(
                    title: 'الدور:',
                    value: Text(
                      state.userModel.role,
                      style: AppStyles.s14,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ProfileDetailsInfo(
                    title: 'التقيم:',
                    value: RatingBarIndicator(
                      rating: 3,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 15.h,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
