part of 'percentage_cubit.dart';

@immutable
sealed class PercentageState {}

final class PercentageInitial extends PercentageState {}

final class PercentageLoading extends PercentageState {}

final class PercentageLoaded extends PercentageState {
  final int value;

  PercentageLoaded(this.value);
}

final class MonthlyTargetLoaded extends PercentageState {
  final String target;

  MonthlyTargetLoaded(this.target);
}

final class PercentageError extends PercentageState {
  final ErrorModel error;

  PercentageError(this.error);
}
