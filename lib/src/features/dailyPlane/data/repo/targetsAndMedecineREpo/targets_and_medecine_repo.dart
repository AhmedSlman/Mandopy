import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/error_model.dart';
import '../../models/doctor_model.dart';
import '../../models/medecation_model.dart';
import '../../models/pharmacy_model.dart';

abstract class TargatsRepoAbstract {
  Future<Either<ErrorModel, List<DoctorModel>>> getDoctors();
  Future<Either<ErrorModel, List<PharmacyModel>>> getPharmacies();
  Future<Either<ErrorModel, List<MedicationModel>>> getMedications();
}
