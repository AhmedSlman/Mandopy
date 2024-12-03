import 'package:dartz/dartz.dart';
import '../models/pharmacy_profile_model.dart';

import '../../../../../core/errors/error_model.dart';

abstract class PharmacyRepoAbstract {
  Future<Either<ErrorModel, PharmacyProfileModel>> getPhrmacyProfile({required String pharmacyId});
}
