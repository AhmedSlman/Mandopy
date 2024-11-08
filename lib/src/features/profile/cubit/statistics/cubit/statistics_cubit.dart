// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/profile/data/models/statistics_model.dart';

import '../../../data/repos/user_repo_abstract.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final UserRepoAbstract userRepoAbstract;
  StatisticsCubit(this.userRepoAbstract) : super(StatisticsInitial());

  Future<void> getUserStatistics() async {
    emit(StatisticsLoading());

    final userStatistics = await userRepoAbstract.getUserStatistics();
    userStatistics.fold(
      (error) => emit(StatisticsError(error)),
      (userStatisticsResponse) {
        emit(StatisticsLoaded(userStatisticsResponse));
      },
    );
  }
}
