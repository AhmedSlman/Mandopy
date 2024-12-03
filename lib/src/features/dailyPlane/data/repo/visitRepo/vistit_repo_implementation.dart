import 'package:dartz/dartz.dart';
import '../../../../../../core/data/api/api_consumer.dart';
import '../../../../../../core/errors/error_model.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../models/visit_model.dart';
import 'vistit_repo.dart';

import '../../models/end_visit_model.dart';

class VisitRepoImplementation implements VisitRepoAbstract {
  final ApiConsumer api;

  VisitRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, VisitModel>> addVisit({
    required String date,
    required String time,
    required List<String> medicationIds,
    String? pharmacyId,
    String? doctorId,
    required String notes,
    required bool isSold,
  }) async {
    try {
    
      final Map<String, dynamic> requestBody = {
        'date': date,
        'time': time,
        'pharmacy_id': pharmacyId,
        'doctor_id': doctorId,
        'notes': notes,
        'is_sold': isSold ? '1' : '0',
      };

      // Add medication_ids dynamically
      for (int i = 0; i < medicationIds.length; i++) {
        requestBody['medication_ids[$i]'] = medicationIds[i];
      }

      final response = await api.post(
        "visits",
        data: requestBody,
        isFormData: true,
      );

      final visitResponse = VisitModel.fromJson(response['visit']);
      return Right(visitResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<VisitModel>>> getAllVisits() async {
    try {
      final response = await api.get(
        "visits",
      );

      List<VisitModel> visits = (response['visits'] as List)
          .map((visit) => VisitModel.fromJson(visit))
          .toList();

      return Right(visits);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, VisitModel>> getVisitDetails(String visitId) async {
    try {
      final response = await api.get(
        "visits/$visitId",
      );

      final visitResponse = VisitModel.fromJson(response);
      return Right(visitResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, VisitModel>> updateVisit(
      {required String visitId, required String status}) async {
    try {
      final response = await api.put(
        "visits/$visitId",
        data: {
          'status': status,
        },
      );
      final visitResponse = VisitModel.fromJson(response);
      return Right(visitResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, bool>> deleteVisit(String visitId) async {
    try {
      await api.delete(
        "visits/$visitId",
      );
      return const Right(true);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, bool>> startVisit(String visitId) async {
    try {
      await api.post(
        "visits/$visitId/start",
      );
      return const Right(true);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, EndVisitModel>> endVisit(
      String visitId, String isSold) async {
    try {
      final response = await api.post(
        "visits/$visitId/end",
        data: {'is_sold': isSold},
      );
      final endVisitResponse = EndVisitModel.fromJson(response);
      return Right(endVisitResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
