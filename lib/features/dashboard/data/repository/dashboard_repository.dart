import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/dashboard/data/service/dashboard_service.dart';

class DashboardRepository {
  final DashboardService service;

  DashboardRepository({required this.service});

  Future<Either<Faliure, LeetcodeDataModel>> getLeetcodeStats() async {
    try {
      return Right(await service.getLeetcodeStats());
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> updateLeetcodeStats(
      LeetcodeDataModel model) async {
    try {
      return Right(await service.updateLeetcodeStats(model));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
