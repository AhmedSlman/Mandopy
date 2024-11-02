import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/pharmacy_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/targetsAndMedecineREpo/targets_and_medecine_repo.dart';

import '../../data/models/doctor_model.dart';

class TargetsCubit extends Cubit<TargetsState> {
  final TargatsRepoAbstract targatsRepoAbstract;
  List<DoctorModel> _doctors = [];
  List<PharmacyModel> _pharmacy = [];

  TargetsCubit(this.targatsRepoAbstract) : super(TargtesInitial());

  Future<void> fetchDoctors() async {
    emit(TargetsLoading());

    final result = await targatsRepoAbstract.getDoctors();

    result.fold(
      (error) => emit(TargetsError(error)),
      (doctors) {
        _doctors = doctors;
        debugPrint("Doctors fetched: ${_doctors.length}");
        emit(TargetsDoctorsLoaded(doctors));
      },
    );
  }

  List<DoctorModel> filterDoctors(String query) {
    if (query.isEmpty) {
      return _doctors;
    }
    return _doctors
        .where(
            (doctor) => doctor.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> fetchPharmacies() async {
    emit(TargetsLoading());

    final result = await targatsRepoAbstract.getPharmacies();

    result.fold(
      (error) => emit(TargetsError(error)),
      (pharmacies) {
        _pharmacy = pharmacies;
        debugPrint("Pharmacies fetched: ${_pharmacy.length}");
        emit(TargetsPharmaciesLoaded(pharmacies));
      },
    );
  }

  List<PharmacyModel> filterPharmacies(String query) {
    if (query.isEmpty) {
      return _pharmacy;
    }
    return _pharmacy
        .where((pharmacy) =>
            pharmacy.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> fetchMedications() async {
    emit(TargetsLoading());

    final result = await targatsRepoAbstract.getMedications();

    result.fold(
      (error) => emit(TargetsError(error)),
      (medications) => emit(TargetsMedicationsLoaded(medications)),
    );
  }
}
