import 'package:dartz/dartz.dart';
import 'package:mandopy/src/features/doctorprofile/data/models/doctor_profile_model.dart';

import '../../../../../core/errors/error_model.dart';

abstract class DoctorRepoAbstract {
  Future<Either<ErrorModel, DoctorProfileModel>> getDoctorProfile(
      {required String doctorId});
}
