import 'package:bloc/bloc.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/prizes/data/models/points_model.dart';
import 'package:mandopy/src/features/prizes/data/repo/bouns_repo.dart';
import 'package:meta/meta.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  final BounsRepoAbstract bounsRepo;

  PointsCubit(this.bounsRepo) : super(PointsInitial());

  Future<void> fetchPoints() async {
    emit(PointsLoading());

    final result = await bounsRepo.getPoints();

    result.fold(
      (error) => emit(PointsError(error)),
      (points) => emit(PointsLoaded(points)),
    );
  }
}
