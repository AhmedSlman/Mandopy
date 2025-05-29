import 'package:dartz/dartz.dart';
import 'package:mandopy/src/core/error/failures.dart';
import 'package:mandopy/src/features/visit/data/model/visit_model.dart';
import 'package:mandopy/src/features/visit/data/repo/visit_repo_abstract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitRepoImplementation implements VisitRepoAbstract {
  final SharedPreferences sharedPreferences;
  static const String _visitKey = 'visits';

  VisitRepoImplementation({required this.sharedPreferences});

  @override
  Future<Either<Failure, void>> saveVisit(VisitModel visit) async {
    try {
      final visits = await getVisitHistory(
        entityId: visit.entityId,
        isDoctor: visit.isDoctor,
      );

      List<VisitModel> updatedVisits = visits.fold(
        (failure) => [],
        (visits) => visits,
      );

      updatedVisits.add(visit);
      final visitsJson = updatedVisits.map((v) => v.toJson()).toList();
      await sharedPreferences.setStringList(
        '${_visitKey}_${visit.entityId}_${visit.isDoctor}',
        visitsJson.map((j) => j.toString()).toList(),
      );

      return const Right(null);
    } catch (e) {
      return Left(VisitFailure(message: "فشل في حفظ الزيارة: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<VisitModel>>> getVisitHistory({
    required String entityId,
    required bool isDoctor,
  }) async {
    try {
      final visitsJson = sharedPreferences.getStringList(
        '${_visitKey}_${entityId}_$isDoctor',
      );

      if (visitsJson == null) {
        return const Right([]);
      }

      final visits = visitsJson
          .map((json) => VisitModel.fromJson(
                Map<String, dynamic>.from(
                  Map<String, dynamic>.from(
                    json as Map<String, dynamic>,
                  ),
                ),
              ))
          .toList();

      return Right(visits);
    } catch (e) {
      return Left(
          VisitFailure(message: "فشل في جلب سجل الزيارات: ${e.toString()}"));
    }
  }
}
