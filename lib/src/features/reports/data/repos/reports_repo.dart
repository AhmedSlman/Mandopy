import 'package:dartz/dartz.dart';
import 'package:mandopy/src/features/reports/data/models/report_model.dart';

import '../../../../../core/errors/error_model.dart';

abstract class ReportsRepo {
  Future<Either<ErrorModel, List<ReportModel>>> getReports();
  Future<Either<ErrorModel, List<ReportModel>>> getReportsBetweenSelectedDates(DateTime startDate, DateTime endDate);
}
