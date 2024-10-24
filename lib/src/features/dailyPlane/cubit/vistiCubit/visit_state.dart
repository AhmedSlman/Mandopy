import 'package:mandopy/src/features/dailyPlane/data/models/visit_model.dart';
import 'package:mandopy/core/errors/error_model.dart';

abstract class VisitState {}

class VisitInitial extends VisitState {}

class VisitLoading extends VisitState {}

class VisitLoaded extends VisitState {
  final List<VisitModel> visits;

  VisitLoaded(this.visits);
}

class VisitDetailsLoaded extends VisitState {
  final VisitModel visit;

  VisitDetailsLoaded(this.visit);
}

class VisitError extends VisitState {
  final ErrorModel error;

  VisitError(this.error);
}
