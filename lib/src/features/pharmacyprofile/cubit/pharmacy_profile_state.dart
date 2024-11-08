part of 'pharmacy_profile_cubit.dart';

@immutable
sealed class PharmacyProfileState {}

final class PharmacyProfileInitial extends PharmacyProfileState {}

final class PharmacyProfileLoading extends PharmacyProfileState {}

final class PharmacyProfileLoaded extends PharmacyProfileState {
  final PharmacyProfileModel pharmacyProfileModel;

  PharmacyProfileLoaded(this.pharmacyProfileModel);
}

final class PharmacyProfileError extends PharmacyProfileState {
  final ErrorModel error;

  PharmacyProfileError(this.error);
}
