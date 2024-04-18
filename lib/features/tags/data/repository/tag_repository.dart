import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'package:leetcode_tracker/features/tags/data/service/tags_service.dart';

class TagRepository {
  final TagService service;

  TagRepository({required this.service});
  Future<Either<Faliure, void>> addTag(TagModel tag) async {
    try {
      return Right(await service.addTag(tag));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, List<TagModel>>> getUserTags() async {
    try {
      return Right(await service.getUserTags());
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> deleteTag(String tagName) async {
    try {
      return Right(await service.deleteTag(tagName));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
