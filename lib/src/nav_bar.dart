import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/app_colors.dart';
import 'features/dailyPlane/presentation/views/daily_plane_view.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/prizes/presentation/views/prizes_view.dart';
import 'features/reports/presentation/views/resports_view.dart';

import 'features/profile/presentation/views/profile_view.dart';

class NavigationBarButton extends StatefulWidget {
  const NavigationBarButton({super.key});

  @override
  _NavigationBarButtonState createState() => _NavigationBarButtonState();
}

class _NavigationBarButtonState extends State<NavigationBarButton> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const DailyPlaneView(),
    const ReportsView(),
    const PrizesView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'الخطة اليومية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'التقارير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'المكافأت',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الصفحة الشخصية',
          ),
        ],
        backgroundColor: AppColors.navBarGrey,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.navBarGreyIcon,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 28,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
