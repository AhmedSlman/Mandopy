import 'package:dartz/dartz.dart';
import '../models/report_model.dart';

import '../../../../../core/errors/error_model.dart';

abstract class ReportsRepo {
  Future<Either<ErrorModel, List<ReportModel>>> getReports();
  Future<Either<ErrorModel, List<ReportModel>>> getReportsBetweenSelectedDates(DateTime startDate, DateTime endDate);
}
