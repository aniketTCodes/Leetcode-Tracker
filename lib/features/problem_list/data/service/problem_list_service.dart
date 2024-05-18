import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_question_model.dart';
import 'dart:developer' as dev show log;

import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';

abstract class ProblemListService {
  Future<List<ProblemListModel>> getProblemLists();
  Future<void> createNewProblemList(ProblemListModel model);
  Future<void> deleteProblemList(String title);
  Future<List<ProblemListQuestionModel>> getProblemListQuestions(String title);
  Future<void> editProblemList(ProblemListModel model);
  Future<void> addQuestion(
      String problemListId, ProblemListQuestionModel model);
}

class ProblemListServiceImpl implements ProblemListService {
  final uid = getIt<FirebaseAuth>().currentUser!.uid;
  final firestore = FirebaseFirestore.instance;
  @override
  Future<List<ProblemListModel>> getProblemLists() async {
    try {
      final collectionRef =
          await firestore.collection('users/$uid/problemLists').get();
      return collectionRef.docs.map(
        (e) {
          final docId = e.id;
          return ProblemListModel.fromFirestore(e.data(), docId);
        },
      ).toList();
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
          .add(model.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  Future<void> deleteProblemList(String title) async {
    try {
      await firestore
          .collection('users/$uid/problemLists/')
          .doc(title)
          .delete();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<List<ProblemListQuestionModel>> getProblemListQuestions(
      String title) async {
    try {
      final res = await firestore
          .collection('users/$uid/problemLists/$title/questions')
          .get();
      return res.docs.map((e) {
        final id = e.id;
        return ProblemListQuestionModel.fromFirestore(id, e.data());
      }).toList();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> editProblemList(ProblemListModel model) async {
    try {
      await firestore
          .collection('users/$uid/problemLists/')
          .doc(model.id)
          .set(model.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> addQuestion(
      String problemListId, ProblemListQuestionModel model) async {
    try {
      await firestore
          .collection('users/$uid/problemLists/$problemListId/questions')
          .add(model.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
