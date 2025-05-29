import 'package:dartz/dartz.dart';
import 'package:mandopy/src/core/error/failures.dart';
import 'package:mandopy/src/features/visit/data/model/visit_model.dart';

abstract class VisitRepoAbstract {
  Future<Either<Failure, void>> saveVisit(VisitModel visit);
  Future<Either<Failure, List<VisitModel>>> getVisitHistory({
    required String entityId,
    required bool isDoctor,
  });
}
