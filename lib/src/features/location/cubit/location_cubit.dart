import 'package:bloc/bloc.dart';
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
    print("Location Services Enabled: $serviceEnabled");

    if (!serviceEnabled) {
      emit(LocationFailure(message: "خدمات الموقع غير مفعلة"));
      return false;
    }
    return true;
  }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print("Initial Location Permission: $permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("Requested Location Permission: $permission");

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

  Future<void> savePharmacyLocation(String pharmacyId) async {
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

      print(
          "Sending Pharmacy Location: Latitude = ${position.latitude}, Longitude = ${position.longitude}");

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

  Future<void> loadDoctorLocation(String doctorId) async {
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

  Future<void> loadPharmacyLocation(String pharmacyId) async {
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

  Future<void> checkAndSaveLocation({
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      emit(LocationLoading());
      print("Checking location services and permissions...");

      if (!await checkLocationServices() || !await checkLocationPermission()) {
        print("Location services or permission check failed.");
        return;
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
          "Current Position: Latitude = ${currentPosition.latitude}, Longitude = ${currentPosition.longitude}");

      final result = isDoctor
          ? await locationRepo.getDoctorLocation(entityId)
          : await locationRepo.getPharmacyLocation(entityId);
      print(
          "Fetching saved location for ${isDoctor ? 'Doctor' : 'Pharmacy'} with ID: $entityId");

      result.fold(
        (error) async {
          print("No saved location found, attempting to save...");

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

          print("Saving ${isDoctor ? 'Doctor' : 'Pharmacy'} location...");
          saveResult.fold(
            (saveError) {
              print("Error saving location: ${saveError.message}");
              emit(LocationFailure(message: saveError.message));
            },
            (_) {
              print("Location saved successfully.");
              emit(LocationSuccess(
                message: 'تم حفظ الموقع بنجاح',
                location: LocationModel(
                  latitude: currentPosition.latitude,
                  longitude: currentPosition.longitude,
                ),
              ));
            },
          );
        },
        (savedLocation) {
          print(
              "Location already saved: ${savedLocation.latitude}, ${savedLocation.longitude}");
          emit(LocationSuccess(
            message: 'الموقع محفوظ بالفعل',
            location: savedLocation,
          ));
        },
      );
    } catch (e) {
      print("Error occurred: ${e.toString()}");
      emit(LocationFailure(
          message: "فشل في التحقق/حفظ الموقع: ${e.toString()}"));
    }
  }
}
