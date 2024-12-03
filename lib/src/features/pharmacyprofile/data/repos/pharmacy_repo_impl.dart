// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:mandopy/core/data/api/api_consumer.dart';
import 'package:mandopy/core/errors/error_model.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/models/pharmacy_profile_model.dart';
import 'package:mandopy/src/features/pharmacyprofile/data/repos/pharmacy_repo_abstract.dart';

import '../../../../../core/errors/exceptions.dart';

class PharmacyRepoImplementation implements PharmacyRepoAbstract {
  final ApiConsumer api;
  PharmacyRepoImplementation(this.api);
  @override
  Future<Either<ErrorModel, PharmacyProfileModel>> getPhrmacyProfile(
      {required String pharmacyId}) async {
    try {
      final response = await api.get(
        "pharmacy-profile/$pharmacyId",
      );

      final pharmacyResponse = PharmacyProfileModel.fromJson(response);
      return Right(pharmacyResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
