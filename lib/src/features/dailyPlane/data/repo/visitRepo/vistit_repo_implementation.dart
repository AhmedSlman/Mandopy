import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/data/cached/cache_helper.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/core/errors/exceptions.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/visit_model.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/visitRepo/vistit_repo.dart';

import '../../models/end_visit_model.dart';

class VisitRepoImplementation implements VisitRepoAbstract {
  final ApiConsumer api;

  VisitRepoImplementation(this.api);

  @override
  Future<Either<ErrorModel, VisitModel>> addVisit({
    required String date,
    required String time,
    required String medicationId,
    String? pharmacyId,
    String? doctorId,
    required String notes,
    required bool isSold,
  }) async {
    try {
      final response = await api.post(
        "visits",
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
        data: {
          'date': date,
          'time': time,
          'medication_id': medicationId,
          'pharmacy_id': pharmacyId,
          'doctor_id': doctorId,
          'notes': notes,
          'is_sold': isSold ? '1' : '0',
        },
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': CacheHelper.getToken(),
        },
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
      await api.delete("visits/$visitId", headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      });
      return const Right(true);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, bool>> startVisit(String visitId) async {
    try {
      await api.post("visits/$visitId/start", headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization':
            'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
      });
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
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
        data: {'is_sold': isSold},
      );
      final endVisitResponse = EndVisitModel.fromJson(response);
      return Right(endVisitResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
