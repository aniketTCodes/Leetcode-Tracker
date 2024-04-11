import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/model/user_stat_model.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/service/leetcode_service.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:leetcode_tracker/features/solutions/data/models/recent_ac_model.dart';

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

  Future<Either<Faliure, RecentAcModel>> getRecentAcSubmissions(
      String username) async {
    try {
      return Right(await service.getRecentAcSubmissions(username));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, ProblemSetModel>> getProblemSet(
      String searchKeyword, int limit) async {
    try {
      return Right(await service.getProblemSet(searchKeyword, limit));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
