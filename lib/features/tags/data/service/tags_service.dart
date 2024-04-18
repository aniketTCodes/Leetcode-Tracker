import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'dart:developer' as dev show log;

abstract class TagService {
  Future<List<TagModel>> getUserTags();
  Future<void> addTag(TagModel tag);
  Future<void> deleteTag(String tagName);
}

class TagServiceImpl extends TagService {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> addTag(TagModel tag) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('tags')
          .doc(tag.name)
          .set(tag.toFirestore());
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<void> deleteTag(String tagName) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('tags')
          .doc(tagName)
          .delete();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<List<TagModel>> getUserTags() async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      final docRef =
          await firestore.collection('users').doc(uid).collection('tags').get();
      return docRef.docs.map((e) => TagModel.fromFirestore(e.data())).toList();
    } on Exception catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
