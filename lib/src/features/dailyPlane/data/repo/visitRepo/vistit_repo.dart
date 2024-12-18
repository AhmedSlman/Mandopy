import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/error_model.dart';
import '../../models/visit_model.dart';

import '../../models/end_visit_model.dart';

abstract class VisitRepoAbstract {
  Future<Either<ErrorModel, VisitModel>> addVisit({
    required String date,
    required String time,
    required List<String> medicationIds,
    String? pharmacyId,
    String? doctorId,
    required String notes,
    required bool isSold,
  });
  Future<Either<ErrorModel, VisitModel>> updateVisit({
    required String visitId,
    required String status,
  });

  Future<Either<ErrorModel, List<VisitModel>>> getAllVisits();

  Future<Either<ErrorModel, VisitModel>> getVisitDetails(String visitId);
  Future<Either<ErrorModel, bool>> deleteVisit(String visitId);
  Future<Either<ErrorModel, bool>> startVisit(String visitId);

  Future<Either<ErrorModel, EndVisitModel>> endVisit(
      String visitId, String isSold);
}
