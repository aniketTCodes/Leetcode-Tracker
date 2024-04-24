import 'dart:io';
import 'dart:typed_data';

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

  Future<void> addImages(List<Uint8List> codeSnippets, String titleSlug);
  //return list of url of images stored in firebase storage
  Future<List<Uint8List>> getImages(String titleSlug);
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
  Future<void> addImages(List<Uint8List> codeSnippets, String titleSlug) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      for (int i = 0; i < codeSnippets.length; i++) {
        final file = codeSnippets[i];
        final ref = firebaseStorage.ref("$uid/$titleSlug/$i.jpg");
        await ref.putData(file);
      }
    } catch (e) {
      dev.log(e.runtimeType.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }

  @override
  Future<List<Uint8List>> getImages(String titleSlug) async {
    final uid = firebaseAuth.currentUser!.uid;
    try {
      final ref = firebaseStorage.ref("$uid/$titleSlug");
      final imageRefs = await ref.listAll();
      List<Uint8List> imageUrls = [];
      for (final imageRef in imageRefs.items) {
        final image = await imageRef.getData();
        await imageRef.delete();
        if (image == null) continue;
        imageUrls.add(image);
      }
      return imageUrls;
    } catch (e) {
      dev.log(e.toString());
      throw MyExpection(message: unknownErrorMessage);
    }
  }
}
