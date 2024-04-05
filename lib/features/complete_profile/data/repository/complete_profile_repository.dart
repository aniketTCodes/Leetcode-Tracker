import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/complete_profile/data/model/profile_data.dart';
import 'package:leetcode_tracker/features/complete_profile/data/service/complete_profile_service.dart';

class CompleteProfileRepository {
  final service = CompleteProfileService();
  Future<Either<Faliure, void>> storeCompleteProfileData(
      ProfileData profileData) async {
    try {
      return Right(await service.storeCompleteProfileData(profileData));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
