import 'package:flutter/foundation.dart';

final class ProfileData {
  final String displayName;
  final String email;
  final int acSubmissions;
  final int easySubmissions;
  final int mediumSubmission;
  final int hardSubmissions;
  final int submissions;

  ProfileData(
      {required this.displayName,
      required this.email,
      required this.acSubmissions,
      required this.easySubmissions,
      required this.mediumSubmission,
      required this.hardSubmissions,
      required this.submissions});

  factory ProfileData.fromMap(Map<String, dynamic> dataMap) {
    return ProfileData(
        displayName: dataMap['displayName'],
        email: dataMap['email'],
        acSubmissions: dataMap['acSubmissions'],
        easySubmissions: dataMap['easySubmissions'],
        mediumSubmission: dataMap['mediumSubmission'],
        hardSubmissions: dataMap['hardSubmissions'],
        submissions: dataMap['submissions']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'acSubmissions': acSubmissions,
      'easySubmissions': easySubmissions,
      'mediumSubmissions': mediumSubmission,
      'hardSubmissions': hardSubmissions,
      'submissions': submissions
    };
  }
}
