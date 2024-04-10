import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'dart:developer' as dev show log;

abstract class DashboardService {
  Future<LeetcodeDataModel> getLeetcodeStats();
  Future<void> updateLeetcodeStats(LeetcodeDataModel model);
}

class DashboardServiceImpl extends DashboardService {
  final _firebaseAuth = getIt<FirebaseAuth>();
  final _leetcodeRepository = getIt<LeetcodeRespository>();
  final _firestore = getIt<FirebaseFirestore>();

  @override
  Future<LeetcodeDataModel> getLeetcodeStats() async {
    try {
      final doc = _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .withConverter(
            fromFirestore: LeetcodeDataModel.fromFirestore,
            toFirestore: (LeetcodeDataModel model, _) => model.toFirestore(),
          );
      final ref = await doc.get();
      final model = ref.data();
      if (model == null) throw MyExpection(message: couldNotFetchDataError);
      return model;
    } on MyExpection {
      rethrow;
    } on FirebaseException catch (e) {
      throw MyExpection(message: e.code);
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> updateLeetcodeStats(LeetcodeDataModel model) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set(model.toFirestore());
    } on FirebaseException catch (e) {
      throw MyExpection(message: e.code);
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
