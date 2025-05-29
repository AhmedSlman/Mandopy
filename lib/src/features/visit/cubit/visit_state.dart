part of 'visit_cubit.dart';

abstract class VisitState extends Equatable {
  const VisitState();

  @override
  List<Object?> get props => [];
}

class VisitInitial extends VisitState {}

class VisitLoading extends VisitState {}

class VisitStarted extends VisitState {
  final String entityId;
  final DateTime startTime;
  final bool isDoctor;

  const VisitStarted({
    required this.entityId,
    required this.startTime,
    required this.isDoctor,
  });

  @override
  List<Object?> get props => [entityId, startTime, isDoctor];
}

class VisitSuccess extends VisitState {
  final String message;

  const VisitSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class VisitFailure extends VisitState {
  final String message;

  const VisitFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class VisitHistoryLoaded extends VisitState {
  final List<VisitModel> visits;

  const VisitHistoryLoaded({required this.visits});

  @override
  List<Object?> get props => [visits];
}
