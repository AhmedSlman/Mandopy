import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/data/api/api_consumer.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../model/location_model.dart';
import 'location_repo_abstract.dart';

class LocationRepoImplementation implements LocationRepoAbstract {
  final ApiConsumer api;

  LocationRepoImplementation(this.api);

  Future<Either<ErrorModel, LocationModel>> handleNullLocation({
    required Future<Either<ErrorModel, LocationModel>> Function() fetchFunction,
    required Future<Either<ErrorModel, LocationModel>> Function(double, double)
        saveFunction,
  }) async {
    try {
      final result = await fetchFunction();
      return result.fold(
        (error) => Left(error),
        (location) async {
          if (location.latitude == 0 && location.longitude == 0) {
            final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            final saveResult =
                await saveFunction(position.latitude, position.longitude);
            return saveResult.fold(
              (saveError) => Left(saveError),
              (newLocation) => Right(newLocation),
            );
          }
          return Right(location);
        },
      );
    } catch (e) {
      return Left(ErrorModel(message: "خطأ غير متوقع: ${e.toString()}"));
    }
  }

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
    return handleNullLocation(
      fetchFunction: () async {
        final response = await api.get(
          "doctors/$doctorId/location",
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
          },
        );
        final locationResponse = LocationModel.fromJson(response);
        return Right(locationResponse);
      },
      saveFunction: (lat, lon) => saveDoctorLocation(
        doctorId: int.parse(doctorId),
        latitude: lat,
        longitude: lon,
      ),
    );
  }

  @override
  Future<Either<ErrorModel, LocationModel>> getPharmacyLocation(
      String pharmacyId) async {
    return handleNullLocation(
      fetchFunction: () async {
        final response = await api.get(
          "pharmacies/$pharmacyId/location",
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
          },
        );
        final locationResponse = LocationModel.fromJson(response);
        return Right(locationResponse);
      },
      saveFunction: (lat, lon) => savePharmacyLocation(
        pharmacyId: pharmacyId,
        latitude: lat,
        longitude: lon,
      ),
    );
  }
}
