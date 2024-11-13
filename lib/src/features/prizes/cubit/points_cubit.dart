import 'package:bloc/bloc.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/prizes/data/models/points_model.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo.dart';

import '../../../../core/common/functions/medal_function.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  final BounsRepoAbstract bounsRepo;

  PointsCubit(this.bounsRepo) : super(PointsInitial());

  Future<void> fetchPoints() async {
    emit(PointsLoading());

    final result = await bounsRepo.getPoints();

    result.fold(
      (error) => emit(PointsError(error)),
      (points) {
        final progress = _calculateProgress(
          int.parse(points.totalPoints),
        );
        emit(
          PointsLoaded(points, progress),
        );
      },
    );
  }

  double _calculateProgress(int totalPoints) {
    int nextMilestone = 100 * ((totalPoints ~/ 100) + 1);
    return totalPoints / nextMilestone;
  }
}
