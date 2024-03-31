import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/core/utils/faliure.dart';
import 'package:leetcode_tracker/features/auth/data/service/auth_service.dart';

class AuthRepository {
  final AuthService service;
  AuthRepository(this.service);

  Future<Either<Faliure, User>> register(String email, String password) async {
    try {
      final user = await service.register(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Faliure(e.message ?? unknownErrorMessage));
    }
  }

  Future<Either<Faliure, User>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final user = await service.loginWithEmailPassword(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Faliure(e.message ?? unknownErrorMessage));
    }
  }

  Future<Either<Faliure, bool>> signOut(String email, String password) async {
    try {
      final result = await service.signOut();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(Faliure(e.message ?? unknownErrorMessage));
    }
  }

  Future<Either<Faliure, void>> verifyUserEmail() async {
    try {
      final result = await service.verifyUser();
      return Right(result);
    } catch (e) {
      return const Left(Faliure(unknownErrorMessage));
    }
  }
}
