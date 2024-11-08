import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';

import '../../../../../core/data/cached/cache_helper.dart';

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: const Icon(Icons.search),
                hintStyle: const TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
            ),
          ),
          if (_filteredResults.isNotEmpty)
            Container(
              color: Colors.white,
              height: _filteredResults.length > 3 ? 200 : 70,
              child: ListView.builder(
                itemCount: _filteredResults.length,
                itemBuilder: (context, index) {
                  final item = _filteredResults[index];
                  return ListTile(
                    title: Text(item.name),
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
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
