import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/visit_model.dart';

abstract class VisitRepoAbstract {
  Future<Either<ErrorModel, VisitModel>> addVisit({
    required String date,
    required String time,
    required String medicationId,
    required String pharmacyId,
    required bool isSold,
  });
  Future<Either<ErrorModel, VisitModel>> updateVisit({
    required String visitId,
    required String status,
  });

  Future<Either<ErrorModel, List<VisitModel>>> getAllVisits();

  Future<Either<ErrorModel, VisitModel>> getVisitDetails(String visitId);
  Future<Either<ErrorModel, bool>> deleteVisit(String visitId);
}
