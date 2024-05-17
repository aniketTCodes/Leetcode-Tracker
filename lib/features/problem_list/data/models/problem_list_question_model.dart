import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';

final class ProblemListQuestionModel {
  final bool solved;
  final Question quesiton;

  ProblemListQuestionModel({required this.solved, required this.quesiton});

  factory ProblemListQuestionModel.fromFirestore(Map<String, dynamic> data) {
    return ProblemListQuestionModel(
        solved: data['solved'],
        quesiton: Question(
            acRate: data['acRate'],
            title: data['title'],
            titleSlug: data['titleSlug'],
            frontendQuestionId: data['frontendQuestionId'],
            difficulty: data['difficulty']));
  }

  Map<String, dynamic> toFirestore() {
    return {
      'solved': solved,
      'acRate': quesiton.acRate,
      'difficulty': quesiton.difficulty,
      'frontendQuestionId': quesiton.frontendQuestionId,
      'title': quesiton.title,
      'titleSlug': quesiton.titleSlug,
    };
  }
}
