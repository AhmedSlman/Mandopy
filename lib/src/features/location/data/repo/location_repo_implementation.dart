import 'package:dartz/dartz.dart';
import '../../../../../core/data/api/api_consumer.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../model/location_model.dart';
import 'location_repo_abstract.dart';

class LocationRepoImplementation implements LocationRepoAbstract {
  final ApiConsumer api;

  LocationRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, LocationModel>> saveDoctorLocation({
    required int doctorId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await api.post(
        "doctors/$doctorId/location",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
        data: {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
        isFormData: true,
      );

      final locationResponse = LocationModel.fromJson(response);
      return Right(locationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, LocationModel>> savePharmacyLocation({
    required String pharmacyId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await api.post(
        "pharmacies/$pharmacyId/location",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
        data: {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
        isFormData: true,
      );

      final locationResponse = LocationModel.fromJson(response);
      return Right(locationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, LocationModel>> getDoctorLocation(
      String doctorId) async {
    try {
      final response = await api.get(
        "doctors/$doctorId/location",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      final locationResponse = LocationModel.fromJson(response);
      return Right(locationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, LocationModel>> getPharmacyLocation(
      String pharmacyId) async {
    try {
      final response = await api.get(
        "pharmacies/$pharmacyId/location",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      final locationResponse = LocationModel.fromJson(response);
      return Right(locationResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
