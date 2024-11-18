import 'package:dartz/dartz.dart';
import '../../../../../../core/data/api/api_consumer.dart';
import '../../../../../../core/errors/error_model.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../models/doctor_model.dart';
import '../../models/medecation_model.dart';
import '../../models/pharmacy_model.dart';
import 'targets_and_medecine_repo.dart';

class TargetsRepoImplementation implements TargatsRepoAbstract {
  final ApiConsumer api;

  TargetsRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, List<DoctorModel>>> getDoctors() async {
    try {
      final response = await api.get(
        "doctors",
      );

      List<DoctorModel> doctors = (response['doctors'] as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList();
      return Right(doctors);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<PharmacyModel>>> getPharmacies() async {
    try {
      final response = await api.get(
        "pharmacies",
      );

      List<PharmacyModel> pharmacies = (response['pharmacies'] as List)
          .map((pharmacy) => PharmacyModel.fromJson(pharmacy))
          .toList();
      return Right(pharmacies);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<MedicationModel>>> getMedications() async {
    try {
      final response = await api.get(
        "medications",
      );

      List<MedicationModel> medications = (response['medications'] as List)
          .map((medication) => MedicationModel.fromJson(medication))
          .toList();
      return Right(medications);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
