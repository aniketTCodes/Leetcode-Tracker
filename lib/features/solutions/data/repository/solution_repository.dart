import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'package:leetcode_tracker/features/solutions/data/service/solution_service.dart';

class SolutionRepository {
  final SolutionService service;

  SolutionRepository({required this.service});

  Future<Either<Faliure, bool>> hasSolution(String titleSlug) async {
    try {
      return Right(await service.hasSolution(titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> setSolution(
      SolutionModel solution, String titleSlug) async {
    try {
      return Right(await service.setSolution(solution, titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, SolutionModel>> getSolution(String titleSlug) async {
    try {
      return Right(await service.getSolution(titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, void>> putCodeSnippets(
      List<Uint8List> codeSnippets, String titleSlug) async {
    try {
      return Right(await service.addImages(codeSnippets, titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }

  Future<Either<Faliure, List<Uint8List>>> getImageUrls(String titleSlug) async {
    try {
      return Right(await service.getImages(titleSlug));
    } on MyExpection catch (e) {
      return Left(Faliure(e.message));
    }
  }
}
