import 'package:bloc/bloc.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/models/pharmacy_profile_model.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/repos/pharmacy_repo_abstract.dart';
import 'package:meta/meta.dart';

part 'pharmacy_profile_state.dart';

class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  final PharmacyRepoAbstract pharmacyRepoAbstract;
  PharmacyProfileCubit(this.pharmacyRepoAbstract)
      : super(PharmacyProfileInitial());

  Future<void> getPharmacyProfile({required String pharmacyId}) async {
    emit(PharmacyProfileLoading());

    final result =
        await pharmacyRepoAbstract.getPhrmacyProfile(pharmacyId: pharmacyId);
    result.fold(
      (error) => emit(PharmacyProfileError(error)),
      (pharmacyProfile) => emit(
        PharmacyProfileLoaded(pharmacyProfile),
      ),
    );
  }
}