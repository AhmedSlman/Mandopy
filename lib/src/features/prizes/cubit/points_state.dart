// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'points_cubit.dart';

abstract class PointsState {}

final class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsLoaded extends PointsState {
  final PointsModel points;
  final double progress;
  PointsLoaded(
    this.points,
    this.progress,
  );
  String get medal => determineMedal(
        int.parse(points.totalPoints),
      );
}

class PointsError extends PointsState {
  final ErrorModel error;
  PointsError(this.error);
}
