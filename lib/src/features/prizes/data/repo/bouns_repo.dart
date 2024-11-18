import 'package:dartz/dartz.dart';
import '../../../../../core/errors/error_model.dart';
import '../models/points_model.dart';

abstract class BounsRepoAbstract {
  Future<Either<ErrorModel, PointsModel>> getPoints();
}
