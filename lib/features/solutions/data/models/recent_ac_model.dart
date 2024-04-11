// To parse this JSON data, do
//
//     final recentAcModel = recentAcModelFromJson(jsonString);

import 'dart:convert';

RecentAcModel recentAcModelFromJson(String str) => RecentAcModel.fromJson(json.decode(str));

String recentAcModelToJson(RecentAcModel data) => json.encode(data.toJson());

class RecentAcModel {
    Data data;

    RecentAcModel({
        required this.data,
    });

    factory RecentAcModel.fromJson(Map<String, dynamic> json) => RecentAcModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    List<RecentAcSubmissionList> recentAcSubmissionList;

    Data({
        required this.recentAcSubmissionList,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        recentAcSubmissionList: List<RecentAcSubmissionList>.from(json["recentAcSubmissionList"].map((x) => RecentAcSubmissionList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "recentAcSubmissionList": List<dynamic>.from(recentAcSubmissionList.map((x) => x.toJson())),
    };
}

class RecentAcSubmissionList {
    String title;

    RecentAcSubmissionList({
        required this.title,
    });

    factory RecentAcSubmissionList.fromJson(Map<String, dynamic> json) => RecentAcSubmissionList(
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
    };
}
