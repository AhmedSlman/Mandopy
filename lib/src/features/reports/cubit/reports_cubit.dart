import 'package:bloc/bloc.dart';
import 'package:mandopy/src/features/reports/data/models/report_model.dart';
import 'package:mandopy/src/features/reports/data/repos/reports_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/error_model.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsRepo reportsRepo;
  ReportsCubit(this.reportsRepo) : super(ReportsInitial());

  Future<void> getReports() async {
    emit(ReportsLoading());

    final result = await reportsRepo.getReports();

    result.fold(
      (error) => emit(ReportsError(error)),
      (reportsResponse) {
        emit(ReportsLoaded(reportsResponse));
      },
    );
  }

  Future<void> getReportsBetweenSelectedDates({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(ReportsLoading());

    final result = await reportsRepo.getReports();

    result.fold(
      (error) => emit(ReportsError(error)),
      (reportsResponse) {
        final filteredReports = reportsResponse.where((report) {
          try {
            final reportDate = DateTime.parse(report.date);

            return reportDate
                    .isAfter(startDate.subtract(const Duration(days: 1))) &&
                reportDate.isBefore(endDate.add(const Duration(days: 1)));
          } catch (e) {
            return false;
          }
        }).toList();

        emit(ReportsLoaded(filteredReports));
      },
    );
  }
}
