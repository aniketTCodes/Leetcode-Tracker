import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/model/user_stat_model.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/service/leetcode_service.dart';

class LeetcodeRespository {
  final LeetcodeService service;

  LeetcodeRespository({required this.service});
  Future<Either<Faliure, UserStatsModel>> fetchUserData(String username) async {
    try {
      return Right(await service.fetchUserData(username));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
