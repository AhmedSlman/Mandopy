import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/visit/data/model/visit_model.dart';
import 'package:mandopy/src/features/visit/data/repo/visit_repo_abstract.dart';

part 'visit_state.dart';

class VisitCubit extends Cubit<VisitState> {
  final VisitRepoAbstract visitRepo;
  final LocationCubit locationCubit;
  DateTime? visitStartTime;
  String? currentEntityId;
  bool isDoctor = false;

  VisitCubit({
    required this.visitRepo,
    required this.locationCubit,
  }) : super(VisitInitial());

  Future<void> startVisit({
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      emit(VisitLoading());
      this.currentEntityId = entityId;
      this.isDoctor = isDoctor;
      visitStartTime = DateTime.now();

      // Start location updates
      locationCubit.isVisitStarted = true;
      await locationCubit.startLocationUpdates();

      emit(VisitStarted(
        entityId: entityId,
        startTime: visitStartTime!,
        isDoctor: isDoctor,
      ));
    } catch (e) {
      emit(VisitFailure(message: "فشل في بدء الزيارة: ${e.toString()}"));
    }
  }

  Future<void> endVisit({
    required String notes,
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      emit(VisitLoading());

      if (visitStartTime == null) {
        emit(VisitFailure(message: "لم يتم بدء الزيارة بعد"));
        return;
      }

      final duration = DateTime.now().difference(visitStartTime!);

      // Stop location updates
      locationCubit.isVisitStarted = false;
      locationCubit.stopLocationUpdates();

      final visit = VisitModel(
        entityId: entityId,
        isDoctor: isDoctor,
        startTime: visitStartTime!,
        endTime: DateTime.now(),
        duration: duration.inMinutes,
        notes: notes,
      );

      final result = await visitRepo.saveVisit(visit);
      result.fold(
        (error) => emit(VisitFailure(message: error.message)),
        (_) {
          visitStartTime = null;
          currentEntityId = null;
          emit(VisitSuccess(message: "تم إنهاء الزيارة بنجاح"));
        },
      );
    } catch (e) {
      emit(VisitFailure(message: "فشل في إنهاء الزيارة: ${e.toString()}"));
    }
  }

  Future<void> cancelVisit() async {
    try {
      emit(VisitLoading());

      // Stop location updates
      locationCubit.isVisitStarted = false;
      locationCubit.stopLocationUpdates();

      visitStartTime = null;
      currentEntityId = null;
      emit(VisitInitial());
    } catch (e) {
      emit(VisitFailure(message: "فشل في إلغاء الزيارة: ${e.toString()}"));
    }
  }

  Future<void> getVisitHistory({
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      emit(VisitLoading());
      final result = await visitRepo.getVisitHistory(
        entityId: entityId,
        isDoctor: isDoctor,
      );
      result.fold(
        (error) => emit(VisitFailure(message: error.message)),
        (visits) => emit(VisitHistoryLoaded(visits: visits)),
      );
    } catch (e) {
      emit(VisitFailure(message: "فشل في جلب سجل الزيارات: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    if (locationCubit.isVisitStarted) {
      locationCubit.stopLocationUpdates();
    }
    return super.close();
  }
}
