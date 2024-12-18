import 'package:dartz/dartz.dart';
import '../../../../../core/data/api/api_consumer.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/points_model.dart';
import 'bouns_repo.dart';

class BounsRepoImplementation implements BounsRepoAbstract {
  final ApiConsumer api;

  BounsRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, PointsModel>> getPoints() async {
    try {
      final response = await api.get(
        'points',
      );

      final pointsData = PointsModel.fromJson(response);
      return Right(pointsData);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
