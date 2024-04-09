import 'package:cloud_firestore/cloud_firestore.dart';

class LeetcodeDataModel {
  final String email;
  final String displayName;
  final String username;
  final int submissions;
  final int acSubmissions;
  final int easySubmissions;
  final int mediumSubmissions;
  final int hardSubmissions;

  LeetcodeDataModel(
      {required this.email,
      required this.username,
      required this.displayName,
      required this.submissions,
      required this.acSubmissions,
      required this.easySubmissions,
      required this.mediumSubmissions,
      required this.hardSubmissions});

  factory LeetcodeDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LeetcodeDataModel(
        username: data?['username'],
        email: data?['email'],
        displayName: data?['displayName'],
        submissions: data?['submissions'],
        acSubmissions: data?['acSubmissions'],
        easySubmissions: data?['easySubmissions'],
        mediumSubmissions: data?['mediumSubmissions'],
        hardSubmissions: data?['hardSubmissions']);
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'username':username,
      'email': email,
      'displayName': displayName,
      'submissions': submissions,
      'acSubmissions': acSubmissions,
      'easySubmissions': easySubmissions,
      'mediumSubmissions': mediumSubmissions,
      'hardSubmissions': hardSubmissions
    };
  }
}
