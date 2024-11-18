import 'package:dartz/dartz.dart';
import '../../../../../core/data/api/api_consumer.dart';
import '../../../../../core/errors/error_model.dart';
import '../models/doctor_profile_model.dart';
import '../models/note_model.dart';
import 'doctor_repo_abstract.dart';

import '../../../../../core/errors/exceptions.dart';

class DoctorRepoImplementation implements DoctorRepoAbstract {
  final ApiConsumer api;

  DoctorRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, DoctorProfileModel>> getDoctorProfile(
      {required String doctorId}) async {
    try {
      final response = await api.get(
        "doctor-profile/$doctorId",
      );

      final doctorResponse = DoctorProfileModel.fromJson(response);
      return Right(doctorResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, NoteModel>> addANote(
      {required String id, required String note}) async {
    try {
      final resposne = await api.post(
        'notes',
        data: {'pharmacy_id': id, 'note': note},
      );
      final noteResponse = NoteModel.fromJson(resposne);
      return Right(noteResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
