import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';

import '../../../../../core/utils/app_assets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  imageUrl: CacheHelper.getData(key: 'image')!.toString(),
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
