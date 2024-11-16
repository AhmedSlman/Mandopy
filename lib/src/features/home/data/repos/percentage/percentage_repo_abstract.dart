import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/error_model.dart';

abstract class PercentageRepoAbstract {
  Future<Either<ErrorModel, int>> getPercentagePerDay();
  Future<Either<ErrorModel, int>> getMonthlyTarget();
}
