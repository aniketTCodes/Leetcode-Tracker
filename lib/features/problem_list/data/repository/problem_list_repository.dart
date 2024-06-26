import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_question_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/service/problem_list_service.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';

class ProblemListRepository {
  final ProblemListService service;

  ProblemListRepository({required this.service});
  Future<Either<Faliure, List<ProblemListModel>>> getProblemLists() async {
    try {
      return Right(await service.getProblemLists());
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> createNewProblemList(
      ProblemListModel model) async {
    try {
      return Right(await service.createNewProblemList(model));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> deleteProblemList(String title) async {
    try {
      return Right(await service.deleteProblemList(title));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, List<ProblemListQuestionModel>>>
      getProblemListQuestions(String title) async {
    try {
      return Right(await service.getProblemListQuestions(title));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> editProblemList(ProblemListModel model) async {
    try {
      return Right(await service.editProblemList(model));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> addQuestion(
      String problemListId, ProblemListQuestionModel model) async {
    try {
      return Right(await service.addQuestion(problemListId, model));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> markDone(
      String problemListId, String titleSlug, bool mark) async {
    try {
      return Right(await service.markDone(problemListId, titleSlug, mark));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> deleteQuestion(
      String problemListId, String titleSlug) async {
    try {
      return Right(await service.deleteQuestion(problemListId, titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
