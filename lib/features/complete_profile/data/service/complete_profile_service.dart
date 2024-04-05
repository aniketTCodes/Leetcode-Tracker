import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/exception/exception.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/complete_profile/data/model/profile_data.dart';

class CompleteProfileService{
  final FirebaseAuth firebaseauth = getIt<FirebaseAuth>();
  final FirebaseFirestore firebaseFirestore = getIt<FirebaseFirestore>();
  Future<void> storeCompleteProfileData(ProfileData profileData)async{
    try{
      final user = firebaseauth.currentUser;
      if(user == null){
        throw MyExpection(message: userNotSignedInErrorMessage);
      }
      await firebaseFirestore.collection('users').doc(user.uid).set(profileData.toMap());
      return;
    }on MyExpection{
      rethrow;
    }
    on Exception{
      throw MyExpection(message: unknownErrorMessage);
    }

  }
}