import 'package:dartz/dartz.dart';
import '../../../../../core/errors/error_model.dart';
import '../model/location_model.dart';

abstract class LocationRepoAbstract {
  Future<Either<ErrorModel, LocationModel>> saveDoctorLocation({
    required int doctorId,
    required double latitude,
    required double longitude,
  });

  Future<Either<ErrorModel, LocationModel>> savePharmacyLocation({
    required String pharmacyId,
    required double latitude,
    required double longitude,
  });

  Future<Either<ErrorModel, LocationModel>> getDoctorLocation(String doctorId);

  Future<Either<ErrorModel, LocationModel>> getPharmacyLocation(
      String pharmacyId);
}
