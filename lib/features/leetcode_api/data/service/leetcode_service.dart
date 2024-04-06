import 'dart:convert';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/model/user_stat_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev show log;

class LeetcodeService {
  Future<UserStatsModel> fetchUserData(String username) async {
    try {
      final response = await http.post(
        Uri.parse('https://leetcode.com/graphql/'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "query": ("""query matchedUser{
    matchedUser(username: "$username"){
        username
        submitStats:submitStatsGlobal{
            acSubmissionNum{
            difficulty
            count
            submissions
        }
        }
    }
}""")
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
