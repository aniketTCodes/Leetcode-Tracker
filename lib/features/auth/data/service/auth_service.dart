import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev show log;

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> register(String email, String password) async {
    try {
      final UserCredential userCred =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = userCred.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      dev.log(e.toString());
      rethrow;
    }
    throw Exception();
  }

  Future<bool> signOut() async {
    try{
      _firebaseAuth.signOut();
      return true;
    }
    on FirebaseAuthException catch (e){
      dev.log(e.toString());
      rethrow;
    }
  }

  Future<User> loginWithEmailPassword(String email,String password) async{
    try{
      final UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      final User? user = userCred.user;
      
      if(user!=null){
        return user;
      }
    }
    on FirebaseAuthException catch (e){
      dev.log(e.toString());
      rethrow;
    }
    throw Exception();
  }

  Future<void> verifyUser()async{
    try{
      final user = _firebaseAuth.currentUser;
      await user?.sendEmailVerification();
    }
    on FirebaseAuthException {
      rethrow;
    }
  }

}