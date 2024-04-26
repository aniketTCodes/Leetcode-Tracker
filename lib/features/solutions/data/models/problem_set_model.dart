// To parse this JSON data, do
//
//     final problemSetModel = problemSetModelFromJson(jsonString);

import 'dart:convert';

ProblemSetModel problemSetModelFromJson(String str) =>
    ProblemSetModel.fromJson(json.decode(str));

String problemSetModelToJson(ProblemSetModel data) =>
    json.encode(data.toJson());

class ProblemSetModel {
  Data data;

  ProblemSetModel({
    required this.data,
  });

  factory ProblemSetModel.fromJson(Map<String, dynamic> json) =>
      ProblemSetModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  ProblemsetQuestionList problemsetQuestionList;

  Data({
    required this.problemsetQuestionList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        problemsetQuestionList:
            ProblemsetQuestionList.fromJson(json["problemsetQuestionList"]),
      );

  Map<String, dynamic> toJson() => {
        "problemsetQuestionList": problemsetQuestionList.toJson(),
      };
}

class ProblemsetQuestionList {
  int total;
  List<Question> questions;

  ProblemsetQuestionList({
    required this.total,
    required this.questions,
  });

  factory ProblemsetQuestionList.fromJson(Map<String, dynamic> json) =>
      ProblemsetQuestionList(
        total: json["total"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  double acRate;
  String difficulty;
  String frontendQuestionId;
  String title;
  String titleSlug;

  Question({
    required this.acRate,
    required this.difficulty,
    required this.frontendQuestionId,
    required this.title,
    required this.titleSlug,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        acRate: json["acRate"]?.toDouble(),
        difficulty: json["difficulty"],
        frontendQuestionId: json["frontendQuestionId"],
        title: json["title"],
        titleSlug: json["titleSlug"],
      );

  Map<String, dynamic> toJson() => {
        "acRate": acRate,
        "difficulty": difficulty,
        "frontendQuestionId": frontendQuestionId,
        "title": title,
        "titleSlug": titleSlug
      };
}

class TopicTag {
  String name;
  String id;
  String slug;

  TopicTag({
    required this.name,
    required this.id,
    required this.slug,
  });

  factory TopicTag.fromJson(Map<String, dynamic> json) => TopicTag(
        name: json["name"],
        id: json["id"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "slug": slug,
      };
}
