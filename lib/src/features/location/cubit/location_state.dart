part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {
  final String? message;
  LocationInitial({this.message});
}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final String message;
  final LocationModel location;

  LocationSuccess({required this.message, required this.location});
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure({required this.message});
}

class LocationCheckSuccess extends LocationState {
  final String message;
  final bool isInCorrectLocation;
  final double distance;

  LocationCheckSuccess({
    required this.message,
    required this.isInCorrectLocation,
    required this.distance,
  });
}
