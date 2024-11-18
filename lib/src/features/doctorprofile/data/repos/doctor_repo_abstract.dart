import 'package:dartz/dartz.dart';
import '../models/doctor_profile_model.dart';
import '../models/note_model.dart';

import '../../../../../core/errors/error_model.dart';

abstract class DoctorRepoAbstract {
  Future<Either<ErrorModel, DoctorProfileModel>> getDoctorProfile(
      {required String doctorId});
  Future<Either<ErrorModel, NoteModel>> addANote({
    required String id,
    required String note,
  });
}
