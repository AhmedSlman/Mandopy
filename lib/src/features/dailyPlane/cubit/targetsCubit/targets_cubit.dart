import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/targetsAndMedecineREpo/targets_and_medecine_repo.dart';

class TargetsCubit extends Cubit<TargetsState> {
  final TargatsRepoAbstract targatsRepoAbstract;

  TargetsCubit({required this.targatsRepoAbstract}) : super(TargtesInitial());

  Future<void> fetchDoctors() async {
    emit(TargetsLoading());

    final result = await targatsRepoAbstract.getDoctors();

    result.fold(
      (error) => emit(TargetsError(error)),
      (doctors) => emit(TargetsDoctorsLoaded(doctors)),
    );
  }

  Future<void> fetchPharmacies() async {
    emit(TargetsLoading());

    final result = await targatsRepoAbstract.getPharmacies();

    result.fold(
      (error) => emit(TargetsError(error)),
      (pharmacies) => emit(TargetsPharmaciesLoaded(pharmacies)),
    );
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
