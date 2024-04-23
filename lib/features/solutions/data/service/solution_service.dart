import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'dart:developer' as dev show log;
// TITLE SLUG OF QUESTION IS USED AS SOLUTION ID

abstract class SolutionService {
  //Check weather the solution exists or not
  Future<bool> hasSolution(String titleSlug);
  //creates solution
  Future<void> setSolution(SolutionModel solution, String titleSlug);
  //Fetch solution from ID
  Future<SolutionModel> getSolution(String titleSlug);

  Future<void> addImages(List<File> codeSnippets,String titleSlug);
}

class SolutionServiceImpl implements SolutionService {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  @override
  Future<SolutionModel> getSolution(String titleSlug) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      final doc = await firestore
          .collection('users')
          .doc(uid)
          .collection('solutions')
          .doc(titleSlug)
          .get();
      if (doc.exists) {
        return SolutionModel.fromFirestore(doc.data()!);
      } else {
        throw MyExpection(message: solutionDoesNotExistError);
      }
    } on MyExpection {
      rethrow;
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<bool> hasSolution(String titleSlug) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      final ref = firestore
          .collection('users')
          .doc(uid)
          .collection('solutions')
          .doc(titleSlug);
      final doc = await ref.get();
      return doc.exists;
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> setSolution(SolutionModel solution, String titleSlug) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      await firestore
          .collection('users')
          .doc(uid)
          .collection('solutions')
          .doc(titleSlug)
          .set(solution.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
  
  @override
  Future<void> addImages(List<File> codeSnippets, String titleSlug) async{
    final uid = firebaseAuth.currentUser!.uid;
    try {
      firebaseStorage.ref()
    } catch (e) {
      
    }
  }
}
