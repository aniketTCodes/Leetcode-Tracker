import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'dart:developer' as dev show log;

abstract class ProblemListService {
  Future<List<ProblemListModel>> getProblemLists();
  Future<void> createNewProblemList(ProblemListModel model);
  Future<void> deleteProblemList(String title);
  
}

class ProblemListServiceImpl implements ProblemListService {
  final uid = getIt<FirebaseAuth>().currentUser!.uid;
  final firestore = FirebaseFirestore.instance;
  @override
  Future<List<ProblemListModel>> getProblemLists() async {
    try {
      final collectionRef =
          await firestore.collection('users/$uid/problemLists').get();
      return collectionRef.docs
          .map((e) => ProblemListModel.fromFirestore(e.data()))
          .toList();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> createNewProblemList(ProblemListModel model) async {
    try {
      await firestore
          .collection('users/$uid/problemLists')
          .doc(model.title)
          .set(model.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  Future<void> deleteProblemList(String title) async{
    try {
      await firestore.collection('users/$uid/problemLists/').doc(title).delete();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
