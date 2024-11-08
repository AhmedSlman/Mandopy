part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsLoading extends StatisticsState {}

final class StatisticsLoaded extends StatisticsState {
  final StatisticsModel statisticsModel;

  StatisticsLoaded(this.statisticsModel);
}

final class StatisticsError extends StatisticsState {
  final ErrorModel error;

  StatisticsError(this.error);
}
