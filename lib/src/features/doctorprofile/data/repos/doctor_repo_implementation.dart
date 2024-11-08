import 'package:dartz/dartz.dart';
import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/doctorprofile/data/models/doctor_profile_model.dart';
import 'package:mandopy/src/features/doctorprofile/data/repos/doctor_repo_abstract.dart';

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
}
