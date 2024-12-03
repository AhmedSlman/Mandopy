import '../../data/models/doctor_model.dart';
import '../../data/models/medecation_model.dart';
import '../../data/models/pharmacy_model.dart';
import '../../../../../core/errors/error_model.dart';

abstract class TargetsState {}

class TargtesInitial extends TargetsState {}

class TargetsLoading extends TargetsState {}

class TargetsDoctorsLoaded extends TargetsState {
  final List<DoctorModel> doctors;

  TargetsDoctorsLoaded(this.doctors);
}

class TargetsPharmaciesLoaded extends TargetsState {
  final List<PharmacyModel> pharmacies;

  TargetsPharmaciesLoaded(this.pharmacies);
}

class TargetsMedicationsLoaded extends TargetsState {
  final List<MedicationModel> medications;

  TargetsMedicationsLoaded(this.medications);
}

class TargetsError extends TargetsState {
  final ErrorModel error;

  TargetsError(this.error);
}
