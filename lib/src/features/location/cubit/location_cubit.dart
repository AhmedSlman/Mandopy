import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../data/model/location_model.dart';
import '../data/repo/location_repo_abstract.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepoAbstract locationRepo;
  final double tolerance = 20.0;

  LocationCubit(this.locationRepo) : super(LocationInitial());

  Future<bool> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationFailure(message: "خدمات الموقع غير مفعلة"));
      return false;
    }
    return true;
  }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationFailure(message: "تم رفض إذن الموقع"));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(LocationFailure(message: "تم رفض إذن الموقع بشكل دائم"));
      return false;
    }
    return true;
  }

  Future<void> checkAndSaveLocation({
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      emit(LocationLoading());

      if (!await checkLocationServices() || !await checkLocationPermission()) {
        return;
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final result = isDoctor
          ? await locationRepo.getDoctorLocation(entityId)
          : await locationRepo.getPharmacyLocation(entityId);

      result.fold(
        (error) async {
          final saveResult = isDoctor
              ? await locationRepo.saveDoctorLocation(
                  doctorId: int.parse(entityId),
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                )
              : await locationRepo.savePharmacyLocation(
                  pharmacyId: entityId,
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                );

          saveResult.fold(
            (saveError) => emit(LocationFailure(message: saveError.message)),
            (_) => emit(LocationSuccess(
              message: 'تم حفظ الموقع بنجاح',
              location: LocationModel(
                latitude: currentPosition.latitude,
                longitude: currentPosition.longitude,
              ),
            )),
          );
        },
        (savedLocation) async {
          if (savedLocation.latitude == 0 && savedLocation.longitude == 0) {
            final saveResult = isDoctor
                ? await locationRepo.saveDoctorLocation(
                    doctorId: int.parse(entityId),
                    latitude: currentPosition.latitude,
                    longitude: currentPosition.longitude,
                  )
                : await locationRepo.savePharmacyLocation(
                    pharmacyId: entityId,
                    latitude: currentPosition.latitude,
                    longitude: currentPosition.longitude,
                  );

            saveResult.fold(
              (saveError) => emit(LocationFailure(message: saveError.message)),
              (_) => emit(LocationSuccess(
                message: 'تم تحديث الموقع الافتراضي بنجاح',
                location: LocationModel(
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                ),
              )),
            );
          } else {
            emit(LocationSuccess(
              message: 'الموقع محفوظ بالفعل ولا يمكن تغييره',
              location: savedLocation,
            ));
          }
        },
      );
    } catch (e) {
      emit(LocationFailure(
          message: "فشل في التحقق/حفظ الموقع: ${e.toString()}"));
    }
  }

  Future<void> checkPharmacyLocation(String pharmacyId) async {
    try {
      emit(LocationLoading());

      final result = await locationRepo.getPharmacyLocation(pharmacyId);
      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (savedLocation) async {
          if (!await checkLocationServices() ||
              !await checkLocationPermission()) {
            return;
          }

          Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          double distanceInMeters = Geolocator.distanceBetween(
            savedLocation.latitude,
            savedLocation.longitude,
            currentPosition.latitude,
            currentPosition.longitude,
          );

          bool isInCorrectLocation = distanceInMeters <= tolerance;
          String message = isInCorrectLocation
              ? "أنت في الموقع الصحيح للصيدلية"
              : "أنت بعيد عن الموقع بمقدار ${distanceInMeters.toStringAsFixed(2)} متر";

          emit(LocationCheckSuccess(
            message: message,
            isInCorrectLocation: isInCorrectLocation,
            distance: distanceInMeters,
          ));
        },
      );
    } catch (e) {
      emit(LocationFailure(
          message: "فشل في التحقق من موقع الصيدلية: ${e.toString()}"));
    }
  }

  Future<void> checkDoctorLocation(String doctorId) async {
    try {
      emit(LocationLoading());

      final result = await locationRepo.getDoctorLocation(doctorId);
      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (savedLocation) async {
          if (!await checkLocationServices() ||
              !await checkLocationPermission()) {
            return;
          }

          Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          double distanceInMeters = Geolocator.distanceBetween(
            savedLocation.latitude,
            savedLocation.longitude,
            currentPosition.latitude,
            currentPosition.longitude,
          );

          bool isInCorrectLocation = distanceInMeters <= tolerance;
          String message = isInCorrectLocation
              ? "أنت في الموقع الصحيح للطبيب"
              : "أنت بعيد عن الموقع بمقدار ${distanceInMeters.toStringAsFixed(2)} متر";

          emit(LocationCheckSuccess(
            message: message,
            isInCorrectLocation: isInCorrectLocation,
            distance: distanceInMeters,
          ));
        },
      );
    } catch (e) {
      emit(LocationFailure(
          message: "فشل في التحقق من موقع الطبيب: ${e.toString()}"));
    }
  }
}
