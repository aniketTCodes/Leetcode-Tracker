import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'dart:developer' as dev show log;

class CodeSnippetsService{
  final firebaseAuth = getIt<FirebaseAuth>();
  final firebaseStorage = FirebaseStorage.instance;
  Future<List<String>> getCodeSnippetUrls(String titleSlug) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      final ref = firebaseStorage.ref('$uid/$titleSlug');
      final codeSnippetRefs = await ref.listAll();
      List<String> urls = [];
      for (final codeSnippetRef in codeSnippetRefs.items) {
        final url = await codeSnippetRef.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }  
}