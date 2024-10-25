import 'package:mandopy/src/features/dailyPlane/data/models/visit_model.dart';
import 'package:mandopy/core/errors/error_model.dart';

abstract class VisitState {}

class VisitInitial extends VisitState {}

class VisitLoading extends VisitState {}

class VisitsLoaded extends VisitState {
  final List<VisitModel> visits;

  VisitsLoaded(this.visits);
}

class VisitDetailsLoaded extends VisitState {
  final VisitModel visit;

  VisitDetailsLoaded(this.visit);
}

class VisitUpdated extends VisitState {
  final VisitModel visit;

  VisitUpdated(this.visit);
}

class VisitDeleted extends VisitState {
  final String message;

  VisitDeleted({required this.message});
}

class VisitError extends VisitState {
  final ErrorModel error;

  VisitError(this.error);
}
