part of 'points_cubit.dart';

abstract class PointsState {}

final class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsLoaded extends PointsState {
  final PointsModel points;
  PointsLoaded(this.points);
}

class PointsError extends PointsState {
  final ErrorModel error;
  PointsError(this.error);
}
