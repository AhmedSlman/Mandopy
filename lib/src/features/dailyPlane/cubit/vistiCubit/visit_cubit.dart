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
    String? pharmacyId,
    String? doctorId,
    required String notes,
    required bool isSold,
  }) async {
    emit(VisitLoading());

    final result = await visitRepo.addVisit(
      date: date,
      time: time,
      medicationId: medicationId,
      pharmacyId: pharmacyId,
      doctorId: doctorId,
      notes: notes,
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

  Future<void> startVisit(String visitId) async {
    emit(VisitLoading());

    final result = await visitRepo.startVisit(visitId);

    result.fold(
      (error) => emit(VisitError(error)),
      (success) => emit(VisitStarted(message: 'زيارة بدأت بنجاح')),
    );
  }

  Future<void> endVisit(String visitId, String isSold) async {
    emit(VisitLoading());

    final result = await visitRepo.endVisit(visitId, isSold);

    result.fold(
      (error) => emit(VisitError(error)),
      (endVisitResponse) => emit(VisitEnded(endVisitResponse)),
    );
  }
}
