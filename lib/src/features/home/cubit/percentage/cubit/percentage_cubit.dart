import 'package:bloc/bloc.dart';
import '../../../../../../core/errors/error_model.dart';
import '../../../data/repos/percentage/percentage_repo_abstract.dart';
import 'package:meta/meta.dart';

import '../../../data/models/montly_target_model.dart';

part 'percentage_state.dart';

class PercentageCubit extends Cubit<PercentageState> {
  final PercentageRepoAbstract percentageRepoAbstract;
  PercentageCubit(this.percentageRepoAbstract) : super(PercentageInitial());

  Future<void> getPercentagePerDay() async {
    emit(PercentageLoading());

    final result = await percentageRepoAbstract.getPercentagePerDay();

    result.fold(
      (error) => emit(PercentageError(error)),
      (value) => emit(PercentageLoaded(value)),
    );
  }

  Future<void> getMonthlyTarget() async {
    emit(PercentageLoading());

    final result = await percentageRepoAbstract.getMonthlyTarget();

    result.fold(
      (error) => emit(PercentageError(error)),
      (target) => emit(MonthlyTargetLoaded(target)),
    );
  }
}
