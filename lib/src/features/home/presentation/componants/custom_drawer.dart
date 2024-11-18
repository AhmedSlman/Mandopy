import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/data/cached/cache_helper.dart';
import '../../../../../core/routes/router_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../auth/cubit/auth_cubit.dart';

import '../../../../../core/utils/app_assets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LogoutSuccessState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.logoutModel.data?.message ?? "")),
          );
          GoRouter.of(context).go(RouterNames.login);
        } else if (state is LogoutFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage.message)),
          );
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              accountName: Text(CacheHelper.getData(key: 'name')),
              accountEmail: Text(CacheHelper.getData(key: 'email')),
              currentAccountPicture: CircleAvatar(
                radius: 35.w,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: CacheHelper.getData(key: 'image'),
                    width: 70.w,
                    height: 70.h,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Icon(Icons.error),
                    errorWidget: (context, url, error) => Image.asset(
                      AppAssets.userProfile,
                      width: 70.w,
                      height: 70.h,
                    ),
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Support or Help
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Support'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Logout option
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
