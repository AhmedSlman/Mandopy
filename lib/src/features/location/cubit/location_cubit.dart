import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../data/model/location_model.dart';
import '../data/repo/location_repo_abstract.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepoAbstract locationRepo;
  final double doctorTolerance = 20.0; // meters
  final double pharmacyTolerance = 30.0; // meters
  StreamSubscription<Position>? _positionStreamSubscription;
  String? currentEntityId;
  bool isDoctor = false;
  bool isVisitStarted = false;

  LocationCubit(this.locationRepo) : super(LocationInitial());

  Future<bool> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationFailure(
          message: "خدمات الموقع غير مفعلة. برجاء تفعيلها من إعدادات الجهاز"));
      return false;
    }
    return true;
  }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationFailure(
            message: "برجاء السماح بالوصول إلى الموقع لاستخدام هذه الخاصية"));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(LocationFailure(
          message:
              "تم رفض إذن الموقع بشكل دائم. برجاء تفعيله من إعدادات التطبيق"));
      return false;
    }
    return true;
  }

  Future<void> checkLocationWithRetry({
    required String entityId,
    required bool isDoctor,
    int maxRetries = 3,
  }) async {
    this.currentEntityId = entityId;
    this.isDoctor = isDoctor;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        if (isDoctor) {
          await checkDoctorLocation(entityId);
        } else {
          await checkPharmacyLocation(entityId);
        }
        break;
      } catch (e) {
        retryCount++;
        if (retryCount == maxRetries) {
          emit(LocationFailure(
              message: "فشل في التحقق من الموقع بعد عدة محاولات"));
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<void> startLocationUpdates() async {
    try {
      if (!await checkLocationServices() || !await checkLocationPermission()) {
        return;
      }

      _positionStreamSubscription?.cancel();
      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Update every 10 meters
        ),
      ).listen((Position position) {
        if (isVisitStarted && currentEntityId != null) {
          checkLocationWithRetry(
            entityId: currentEntityId!,
            isDoctor: isDoctor,
          );
        }
      });
    } catch (e) {
      emit(LocationFailure(message: "فشل في بدء تحديثات الموقع"));
    }
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
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

          bool isInCorrectLocation = distanceInMeters <= pharmacyTolerance;
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

          bool isInCorrectLocation = distanceInMeters <= doctorTolerance;
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

  @override
  Future<void> close() {
    stopLocationUpdates();
    return super.close();
  }
}
