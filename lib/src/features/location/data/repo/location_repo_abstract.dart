import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/location/data/model/location_model.dart';

abstract class LocationRepoAbstract {
  Future<Either<ErrorModel, LocationModel>> saveDoctorLocation({
    required int doctorId,
    required double latitude,
    required double longitude,
  });

  Future<Either<ErrorModel, LocationModel>> savePharmacyLocation({
    required int pharmacyId,
    required double latitude,
    required double longitude,
  });

  Future<Either<ErrorModel, LocationModel>> getDoctorLocation(int doctorId);

  Future<Either<ErrorModel, LocationModel>> getPharmacyLocation(int pharmacyId);
}
