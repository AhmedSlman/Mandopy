import 'package:dartz/dartz.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/reports/data/models/report_model.dart';
import 'package:mandopy/src/features/reports/data/repos/reports_repo.dart';

import '../../../../../core/data/api/api_consumer.dart';
import '../../../../../core/errors/exceptions.dart';

class ReportsRepoImplementation implements ReportsRepo {
  final ApiConsumer api;

  ReportsRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, List<ReportModel>>> getReports() async {
    try {
      final response = await api.get(
        'reports',
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
      );

      List<ReportModel> reports = (response['reports'] as List)
          .map((report) => ReportModel.fromJson(report))
          .toList();
      return Right(reports);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<ReportModel>>> getReportsBetweenSelectedDates(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await api.get(
        'reports',
        headers: {
          'Accept': 'application/vnd.api+json',
          'Authorization':
              'Bearer 6|1U6J0ZvrTaaSWe9h2lyyVoLzOYir3c8ZUt0oKTCue7686e99',
        },
        queryParameters: {
          'start_date': startDate.toIso8601String(),
          'end_date': endDate.toIso8601String(),
        },
      );

      List<ReportModel> reports = (response['reports'] as List)
          .map((report) => ReportModel.fromJson(report))
          .toList();
      return Right(reports);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
