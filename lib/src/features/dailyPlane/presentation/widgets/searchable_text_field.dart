import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/targetsCubit/targets_cubit.dart';
import '../../cubit/targetsCubit/targets_state.dart';
import '../../../../../core/data/cached/cache_helper.dart';
import '../../../../../core/theme/app_colors.dart';

class SearchableTextField extends StatefulWidget {
  final String hintText;
  final Function(String)? onDoctorSelected;
  final Function(String)? onPharmacySelected;

  const SearchableTextField({
    super.key,
    required this.hintText,
    this.onDoctorSelected,
    this.onPharmacySelected,
  });

  @override
  _SearchableTextFieldState createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _filteredResults = [];
  String? role;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _controller.addListener(_onSearch);
  }

  void _initializeData() {
    role = CacheHelper.getData(key: 'role');
    final cubit = BlocProvider.of<TargetsCubit>(context);
    debugPrint("Fetched role from cache: $role");

    if (role == 'تجاري') {
      cubit.fetchPharmacies();
      debugPrint("Fetching only pharmacies for role تجاري...");
    } else if (role == 'علمي') {
      cubit.fetchDoctors();
      cubit.fetchPharmacies();
      debugPrint("Fetching both doctors and pharmacies for role علمي...");
    }
  }

  void _onSearch() {
    final query = _controller.text;
    final cubit = BlocProvider.of<TargetsCubit>(context);
    debugPrint("Searching for: $query");

    setState(() {
      if (role == 'تجاري') {
        _filteredResults = cubit.filterPharmacies(query);
        debugPrint("Filtered pharmacies (تجاري): $_filteredResults");
      } else if (role == 'علمي') {
        final doctors = cubit.filterDoctors(query);
        final pharmacies = cubit.filterPharmacies(query);
        _filteredResults = [
          ...doctors,
          ...pharmacies,
        ];
        debugPrint("Filtered mixed results (علمي): $_filteredResults");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TargetsCubit, TargetsState>(
      listener: (context, state) {
        if (state is TargetsDoctorsLoaded || state is TargetsPharmaciesLoaded) {
          _onSearch();
        }
      },
      child: Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _isFocused
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: _isFocused
                    ? [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color:
                        _isFocused ? AppColors.primaryColor : Colors.grey[400],
                    size: 20.r,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          if (_filteredResults.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxHeight: _filteredResults.length > 3 ? 200.h : 70.h,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredResults.length,
                itemBuilder: (context, index) {
                  final item = _filteredResults[index];
                  final isLast = index == _filteredResults.length - 1;

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _controller.text = item.name;
                        setState(() {
                          _filteredResults.clear();
                        });

                        if (role == 'تجاري') {
                          widget.onPharmacySelected?.call(item.id.toString());
                          debugPrint("Selected pharmacy ID: ${item.id}");
                        } else if (role == 'علمي' && item.type == 'doctor') {
                          widget.onDoctorSelected?.call(item.id.toString());
                          debugPrint("Selected doctor ID: ${item.id}");
                        } else if (role == 'علمي' && item.type == 'pharmacy') {
                          widget.onPharmacySelected?.call(item.id.toString());
                          debugPrint("Selected pharmacy ID: ${item.id}");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: !isLast
                              ? Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 1,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.type == 'doctor'
                                  ? Icons.medical_services_outlined
                                  : Icons.local_pharmacy_outlined,
                              size: 20.r,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
