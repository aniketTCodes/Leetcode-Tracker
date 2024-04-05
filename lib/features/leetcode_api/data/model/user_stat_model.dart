import 'dart:convert';

UserStatsModel userStatsModelFromJson(String str) => UserStatsModel.fromJson(json.decode(str));

String userStatsModelToJson(UserStatsModel data) => json.encode(data.toJson());

class UserStatsModel {
    Data data;

    UserStatsModel({
        required this.data,
    });

    factory UserStatsModel.fromJson(Map<String, dynamic> json) => UserStatsModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    MatchedUser matchedUser;

    Data({
        required this.matchedUser,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        matchedUser: MatchedUser.fromJson(json["matchedUser"]),
    );

    Map<String, dynamic> toJson() => {
        "matchedUser": matchedUser.toJson(),
    };
}

class MatchedUser {
    String username;
    SubmitStats submitStats;

    MatchedUser({
        required this.username,
        required this.submitStats,
    });

    factory MatchedUser.fromJson(Map<String, dynamic> json) => MatchedUser(
        username: json["username"],
        submitStats: SubmitStats.fromJson(json["submitStats"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "submitStats": submitStats.toJson(),
    };
}

class SubmitStats {
    List<AcSubmissionNum> acSubmissionNum;

    SubmitStats({
        required this.acSubmissionNum,
    });

    factory SubmitStats.fromJson(Map<String, dynamic> json) => SubmitStats(
        acSubmissionNum: List<AcSubmissionNum>.from(json["acSubmissionNum"].map((x) => AcSubmissionNum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "acSubmissionNum": List<dynamic>.from(acSubmissionNum.map((x) => x.toJson())),
    };
}

class AcSubmissionNum {
    String difficulty;
    int count;
    int submissions;

    AcSubmissionNum({
        required this.difficulty,
        required this.count,
        required this.submissions,
    });

    factory AcSubmissionNum.fromJson(Map<String, dynamic> json) => AcSubmissionNum(
        difficulty: json["difficulty"],
        count: json["count"],
        submissions: json["submissions"],
    );

    Map<String, dynamic> toJson() => {
        "difficulty": difficulty,
        "count": count,
        "submissions": submissions,
    };
}
