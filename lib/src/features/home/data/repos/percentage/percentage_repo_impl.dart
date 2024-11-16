import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/home/data/repos/percentage/percentage_repo_abstract.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../models/montly_target_model.dart';

class PercentageRepoImpl implements PercentageRepoAbstract {
  final ApiConsumer api;

  PercentageRepoImpl(this.api);
  @override
  Future<Either<ErrorModel, MontlyTargetModel>> getMonthlyTarget() async {
    try {
      final response = await api.get(
        "monthly-target",
      );

      if (response is String) {
        return Right(MontlyTargetModel(
          monthlyTarget: 0,
          completedVisits: 0,
          percentage: "0%",
        ));
      }

      final montlyTargetModel = MontlyTargetModel.fromJson(response);

      return Right(montlyTargetModel);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, int>> getPercentagePerDay() async {
    try {
      final response = await api.get(
        "percentage-per-day",
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
