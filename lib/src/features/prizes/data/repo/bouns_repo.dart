import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/prizes/data/models/points_model.dart';

abstract class BounsRepoAbstract {
  Future<Either<ErrorModel, PointsModel>> getPoints();
}
