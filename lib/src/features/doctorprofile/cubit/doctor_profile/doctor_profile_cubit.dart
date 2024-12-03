import 'package:bloc/bloc.dart';
import '../../../../../core/errors/error_model.dart';
import '../../data/models/doctor_profile_model.dart';
import '../../data/repos/doctor_repo_abstract.dart';
import 'package:meta/meta.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorRepoAbstract doctorRepoAbstract;
  DoctorProfileCubit(this.doctorRepoAbstract) : super(DoctorProfileInitial());

  Future<void> getDoctorProfile({required String doctorId}) async {
    emit(DoctorProfileLoading());

    final result =
        await doctorRepoAbstract.getDoctorProfile(doctorId: doctorId);

    result.fold(
      (error) => emit(DoctorProfileError(error)),
      (doctorProfile) => emit(DoctorProfileLoaded(doctorProfile)),
    );
  }
}
