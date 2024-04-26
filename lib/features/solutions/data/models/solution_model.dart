import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';

class SolutionModel {
  final String questionTitle;
  final String titleSlug;
  final String difficulty;
  final String problemGoal;
  final String optimization;
  final String rationale;
  final List<TagModel> tags;

  SolutionModel(
      {required this.questionTitle,
      required this.difficulty,
      required this.problemGoal,
      required this.optimization,
      required this.rationale,
      required this.tags,
      required this.titleSlug,
      });

  factory SolutionModel.fromFirestore(Map<String, dynamic> map) {
    return SolutionModel(
        questionTitle: map['questionTitle'],
        difficulty: map['difficulty'],
        problemGoal: map['problemGoal'],
        optimization: map['optimization'],
        rationale: map['rationale'],
        titleSlug: map['titleSlug'],
        tags: (map['tags'] as List<dynamic>)
            .map((e) => TagModel.fromFirestore(e as Map<String,dynamic>))
            .toList());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'questionTitle': questionTitle,
      'difficulty': difficulty,
      'problemGoal': problemGoal,
      'optimization': optimization,
      'rationale': rationale,
      'titleSlug':titleSlug,
      'tags': tags.map((e) => e.toFirestore()).toList()
    };
  }
}
