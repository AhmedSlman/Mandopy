part of 'reports_cubit.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

final class ReportsLoading extends ReportsState {}

final class ReportsLoaded extends ReportsState {
  final List<ReportModel> reports;

  ReportsLoaded(this.reports);
}
final class ReportsError extends ReportsState {
    final ErrorModel error;

  ReportsError(this.error);
  
}
