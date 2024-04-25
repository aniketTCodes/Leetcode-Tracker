import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/codeSnippets/data/service/code_snippets_service.dart';

class CodeSnippetsRepository {
  final CodeSnippetsService service;

  CodeSnippetsRepository({required this.service});
  Future<Either<Faliure, List<String>>> getCodeSnippetsUrl(
      String titleSlug) async {
    try {
      return Right(await service.getCodeSnippetUrls(titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
