import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/core/errors/exceptions.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/doctor_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/medecation_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/pharmacy_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/targetsAndMedecineREpo/targets_and_medecine_repo.dart';

class TargetsRepoImplementation implements TargatsRepoAbstract {
  final ApiConsumer api;

  TargetsRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, List<DoctorModel>>> getDoctors() async {
    try {
      final response = await api.get(
        "doctors",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
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
