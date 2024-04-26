import 'package:leetcode_tracker/core/constants/config.dart';

String recentAcQuery(String username) => """query recentAcSubmissions {
        recentAcSubmissionList(username: "$username", limit: $recentAcQueryLimit) {
          title
        }
      }""";

String fetchUSerData(String username) => """query matchedUser{
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
}""";

String fetchProblemSet(
  String searchKeyword,
  int limit,
) {
  return """
    query problemsetQuestionList{
  problemsetQuestionList: questionList(
    categorySlug: "$categorySlug"
    limit: $limit
    skip: $skip
    filters: {searchKeywords:"$searchKeyword"}
  ) {
    total: totalNum
    questions: data {
      acRate
      difficulty
      frontendQuestionId: questionFrontendId
      title
      titleSlug
      
    }
  }
}
    """;
}
