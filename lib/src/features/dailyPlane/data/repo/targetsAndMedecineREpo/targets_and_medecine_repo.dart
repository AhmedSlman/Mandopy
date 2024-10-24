import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/doctor_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/medecation_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/pharmacy_model.dart';

abstract class TargatsRepoAbstract {
  Future<Either<ErrorModel, List<DoctorModel>>> getDoctors();
  Future<Either<ErrorModel, List<PharmacyModel>>> getPharmacies();
  Future<Either<ErrorModel, List<MedicationModel>>> getMedications();
}
