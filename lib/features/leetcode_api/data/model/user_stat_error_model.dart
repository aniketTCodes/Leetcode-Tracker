import 'dart:convert';

UserStatErrorModel userStatErrorModelFromJson(String str) => UserStatErrorModel.fromJson(json.decode(str));

String userStatErrorModelToJson(UserStatErrorModel data) => json.encode(data.toJson());

class UserStatErrorModel {
    List<Error> errors;
    Data data;

    UserStatErrorModel({
        required this.errors,
        required this.data,
    });

    factory UserStatErrorModel.fromJson(Map<String, dynamic> json) => UserStatErrorModel(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
        "data": data.toJson(),
    };
}

class Data {
    dynamic matchedUser;

    Data({
        required this.matchedUser,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        matchedUser: json["matchedUser"],
    );

    Map<String, dynamic> toJson() => {
        "matchedUser": matchedUser,
    };
}

class Error {
    String message;
    List<Location> locations;
    List<String> path;
    Extensions extensions;

    Error({
        required this.message,
        required this.locations,
        required this.path,
        required this.extensions,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
        path: List<String>.from(json["path"].map((x) => x)),
        extensions: Extensions.fromJson(json["extensions"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "path": List<dynamic>.from(path.map((x) => x)),
        "extensions": extensions.toJson(),
    };
}

class Extensions {
    bool handled;

    Extensions({
        required this.handled,
    });

    factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
        handled: json["handled"],
    );

    Map<String, dynamic> toJson() => {
        "handled": handled,
    };
}

class Location {
    int line;
    int column;

    Location({
        required this.line,
        required this.column,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        line: json["line"],
        column: json["column"],
    );

    Map<String, dynamic> toJson() => {
        "line": line,
        "column": column,
    };
}
