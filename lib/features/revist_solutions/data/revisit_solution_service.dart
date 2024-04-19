import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'dart:developer' as dev show log;

class RevisitSolutionService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<List<SolutionModel>> getAllSolutions() async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      final result = await firestore
          .collection('users')
          .doc(uid)
          .collection('solutions')
          .get();
      return result.docs
          .map((e) => SolutionModel.fromFirestore(e.data()))
          .toList();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
