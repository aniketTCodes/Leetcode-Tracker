import 'dart:convert';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/core/network/api_endpoints.dart';
import 'package:leetcode_tracker/core/network/leetcode_query_builder.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/model/user_stat_model.dart';
import 'package:http/http.dart' as http;
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'dart:developer' as dev show log;

import 'package:leetcode_tracker/features/solutions/data/models/recent_ac_model.dart';

// Future<RecentAcModel> getRecentAcSubmissions(String username);
// Future<ProblemSetModel> getProblemSet(String searchKeyword,int limit);
class LeetcodeService {
  Future<ProblemSetModel> getProblemSet(String searchKeyword, int limit) async {
    try {
      final query = fetchProblemSet(searchKeyword, limit);
      dev.log(query);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({"query": query}),
      );
      dev.log(response.body);
      if (response.statusCode == 200) {
        return problemSetModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  Future<RecentAcModel> getRecentAcSubmissions(String username) async {
    try {
      final query = recentAcQuery(username);
      dev.log(query);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(
          {
            "query": recentAcQuery(username),
          },
        ),
      );
      dev.log(response.body);
      if (response.statusCode == 200) {
        return recentAcModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  Future<UserStatsModel> fetchUserData(String username) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(
          {
            "query": fetchUSerData(username),
          },
        ),
      );
      dev.log(response.body);

      if (response.statusCode == 200) {
        if (profileExists(response.body)) {
          return userStatsModelFromJson(response.body);
        } else {
          throw MyExpection(message: leetcodeProfileDoesNotExistErrorMessage);
        }
      } else {
        throw MyExpection(message: unknownErrorMessage);
      }
    } on MyExpection {
      rethrow;
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  bool profileExists(String response) {
    final decodedResponse = json.decode(response);
    if (decodedResponse['data']['matchedUser'] == null) {
      return false;
    } else {
      return true;
    }
  }
}
