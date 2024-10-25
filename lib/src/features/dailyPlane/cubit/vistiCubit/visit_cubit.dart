import 'package:bloc/bloc.dart';
import 'package:mandopy/src/features/dailyPlane/data/repo/visitRepo/vistit_repo.dart';
import 'visit_state.dart';

class VisitCubit extends Cubit<VisitState> {
  final VisitRepoAbstract visitRepo;

  VisitCubit(this.visitRepo) : super(VisitInitial());

  Future<void> addVisit({
    required String date,
    required String time,
    required String medicationId,
    required String pharmacyId,
    required bool isSold,
  }) async {
    emit(VisitLoading());

    final result = await visitRepo.addVisit(
      date: date,
      time: time,
      medicationId: medicationId,
      pharmacyId: pharmacyId,
      isSold: isSold,
    );

    result.fold(
      (error) => emit(VisitError(error)),
      (visitResponse) {
        emit(VisitsLoaded([visitResponse]));
      },
    );
  }

  Future<void> getAllVisits() async {
    emit(VisitLoading());

    final result = await visitRepo.getAllVisits();

    result.fold(
      (error) => emit(VisitError(error)),
      (visits) => emit(VisitsLoaded(visits)),
    );
  }

  Future<void> getVisitDetails(String visitId) async {
    emit(VisitLoading());

    final result = await visitRepo.getVisitDetails(visitId);

    result.fold(
      (error) => emit(VisitError(error)),
      (visit) => emit(VisitDetailsLoaded(visit)),
    );
  }

  Future<void> updateVisit({
    required String visitId,
    required String status,
  }) async {
    emit(VisitLoading());

    final result = await visitRepo.updateVisit(
      visitId: visitId,
      status: status,
    );

    result.fold(
      (error) => emit(VisitError(error)),
      (visitResponse) => emit(VisitsLoaded([visitResponse])),
    );
  }

  Future<void> deleteVisit(String visitId) async {
    emit(VisitLoading());

    final result = await visitRepo.deleteVisit(visitId);

    result.fold(
      (error) => emit(VisitError(error)),
      (success) {
        getAllVisits();
        emit(VisitDeleted(message: 'تم حذف الزيارة بنجاح'));
      },
    );
  }
}