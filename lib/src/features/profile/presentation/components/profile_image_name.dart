import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/routes/router_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/user/user_cubit.dart';

class ProfileImageAndname extends StatelessWidget {
  const ProfileImageAndname({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is UserLoading,
          child: state is UserLoaded
              ? Column(
                  children: [
                    GestureDetector(
                      onTap: () => GoRouter.of(context)
                          .push(RouterNames.editProfileView),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 35.w,
                            child: Image.asset(
                              AppAssets.userProfile,
                              width: 70.w,
                              height: 70.h,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.primaryColor,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 14.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      state.userModel.name,
                      style: AppStyles.s16.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : state is UserError
                  ? Center(
                      child: Text('Error: ${state.error.message}'),
                    )
                  : const Center(child: Text('No user data available')),
        );
      },
    );
  }
}
