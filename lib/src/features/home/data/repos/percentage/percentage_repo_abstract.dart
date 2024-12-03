import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/error_model.dart';
import '../../models/montly_target_model.dart';

abstract class PercentageRepoAbstract {
  Future<Either<ErrorModel, int>> getPercentagePerDay();
  Future<Either<ErrorModel, MontlyTargetModel>> getMonthlyTarget();
}
