import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/revist_solutions/data/revisit_solution_service.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';

class RevisitSolutionRepository {
  final RevisitSolutionService service;

  RevisitSolutionRepository({required this.service});
  Future<Either<Faliure, List<SolutionModel>>> getAllSolutions() async {
    try {
      return Right(await service.getAllSolutions());
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
