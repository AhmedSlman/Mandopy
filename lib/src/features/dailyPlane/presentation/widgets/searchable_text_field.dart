// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';

class SearchableTextField extends StatefulWidget {
  final String hintText;
  final String? selectedPurpose;
  final Function(String)? onDoctorSelected;
  final Function(String)? onPharmacySelected;

  const SearchableTextField({
    super.key,
    required this.hintText,
    this.selectedPurpose,
    this.onDoctorSelected,
    this.onPharmacySelected,
  });

  @override
  _SearchableTextFieldState createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _controller.addListener(_onSearch);
    debugPrint(
        "Initialized SearchableTextField with purpose: ${widget.selectedPurpose}");
  }

  void _initializeData() {
    final cubit = BlocProvider.of<TargetsCubit>(context);
    debugPrint("Fetching data for selected purpose: ${widget.selectedPurpose}");

    if (widget.selectedPurpose == 'طبيب') {
      cubit.fetchDoctors();
      debugPrint("Fetching doctors...");
    } else if (widget.selectedPurpose == 'صيدلية') {
      cubit.fetchPharmacies();
      debugPrint("Fetching pharmacies...");
    } else if (widget.selectedPurpose == 'مختلط') {
      cubit.fetchDoctors();
      cubit.fetchPharmacies();
      debugPrint("Fetching both doctors and pharmacies...");
    }
  }

  void _onSearch() {
    final query = _controller.text;
    final cubit = BlocProvider.of<TargetsCubit>(context);
    debugPrint("Searching for: $query");

    setState(() {
      if (widget.selectedPurpose == 'طبيب') {
        _filteredResults = cubit.filterDoctors(query);
        debugPrint("Filtered doctors: $_filteredResults");
      } else if (widget.selectedPurpose == 'صيدلية') {
        _filteredResults = cubit.filterPharmacies(query);
        debugPrint("Filtered pharmacies: $_filteredResults");
      } else if (widget.selectedPurpose == 'مختلط') {
        _filteredResults = [
          ...cubit.filterDoctors(query),
          ...cubit.filterPharmacies(query)
        ];
        debugPrint("Filtered mixed results: $_filteredResults");
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

                      if (widget.selectedPurpose == 'طبيب') {
                        widget.onDoctorSelected?.call(item.id.toString());
                        debugPrint("Selected doctor ID: ${item.id}");
                      } else if (widget.selectedPurpose == 'صيدلية') {
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
