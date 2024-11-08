part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileLoading extends DoctorProfileState {}

final class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileModel doctorProfileModel;

  DoctorProfileLoaded(this.doctorProfileModel);
}

final class DoctorProfileError extends DoctorProfileState {
  final ErrorModel error;

  DoctorProfileError(this.error);
}
