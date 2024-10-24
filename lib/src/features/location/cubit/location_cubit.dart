import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mandopy/src/features/location/data/model/location_model.dart';
import 'package:mandopy/src/features/location/data/repo/location_repo_abstract.dart';

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

  Future<void> saveDoctorLocation(int doctorId) async {
    try {
      emit(LocationLoading());

      if (!await checkLocationServices() || !await checkLocationPermission()) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      final result = await locationRepo.saveDoctorLocation(
        doctorId: doctorId,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (location) => emit(LocationSuccess(
          message: 'تم حفظ موقع الدكتور بنجاح',
          location: location,
        )),
      );
    } catch (e) {
      emit(LocationFailure(message: "فشل في حفظ الموقع: ${e.toString()}"));
    }
  }

  Future<void> savePharmacyLocation(int pharmacyId) async {
    try {
      emit(LocationLoading());

      if (!await checkLocationServices() || !await checkLocationPermission()) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      final result = await locationRepo.savePharmacyLocation(
        pharmacyId: pharmacyId,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (location) => emit(LocationSuccess(
          message: 'تم حفظ موقع الصيدلية بنجاح',
          location: location,
        )),
      );
    } catch (e) {
      emit(LocationFailure(message: "فشل في حفظ الموقع: ${e.toString()}"));
    }
  }

  Future<void> loadDoctorLocation(int doctorId) async {
    try {
      emit(LocationLoading());

      final result = await locationRepo.getDoctorLocation(doctorId);
      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (location) => emit(LocationSuccess(
          message: 'تم تحميل موقع الدكتور بنجاح',
          location: location,
        )),
      );
    } catch (e) {
      emit(LocationFailure(message: "فشل في استرجاع الموقع: ${e.toString()}"));
    }
  }

  Future<void> loadPharmacyLocation(int pharmacyId) async {
    try {
      emit(LocationLoading());

      final result = await locationRepo.getPharmacyLocation(pharmacyId);
      result.fold(
        (error) => emit(LocationFailure(message: error.message)),
        (location) => emit(LocationSuccess(
          message: 'تم تحميل موقع الصيدلية بنجاح',
          location: location,
        )),
      );
    } catch (e) {
      emit(LocationFailure(message: "فشل في استرجاع الموقع: ${e.toString()}"));
    }
  }

  Future<void> checkDoctorLocation(int doctorId) async {
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
              ? "أنت في الموقع الصحيح للدكتور"
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
          message: "فشل في التحقق من موقع الدكتور: ${e.toString()}"));
    }
  }

  Future<void> checkPharmacyLocation(int pharmacyId) async {
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
}
