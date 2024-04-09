import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/complete_profile/data/model/profile_data.dart';
import 'package:leetcode_tracker/features/complete_profile/data/repository/complete_profile_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/model/user_stat_model.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:meta/meta.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final FirebaseAuth _auth = getIt<FirebaseAuth>();
  final LeetcodeRespository _leetcodeRepo = getIt<LeetcodeRespository>();
  final repo = CompleteProfileRepository();
  CompleteProfileBloc() : super(CompleteProfileLoadingState()) {
    on<CompleteProfileInitEvent>((event, emit) async {
      final user = getIt<FirebaseAuth>().currentUser;
      if (user == null) {
        emit(CompleteProfileErrorState());
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.data() != null) {
        emit(CompleteProfileDoneState());
        return;
      }

      emit(CompleteProfileInitial());
    });
    on<CompleteProfileSaveEvent>((event, emit) async {
      final prevState = state as CompleteProfileInitial;
      emit(CompleteProfileLoadingState());
      UserStatsModel? userStates;
      final leetcodeResult =
          await _leetcodeRepo.fetchUserData(event.displayName);
      leetcodeResult.fold((l) => emit(prevState.copyWith(l.message)), (r) {
        userStates = r;
      });
      if (userStates == null) return;

      final user = _auth.currentUser;
      if (user == null) {
        emit(CompleteProfileErrorState());
        return;
      }

      final result = await repo.storeCompleteProfileData(ProfileData(
        username: event.username,
          displayName: event.displayName,
          email: user.email!,
          acSubmissions:
              userStates!.data.matchedUser.submitStats.acSubmissionNum[0].count,
          easySubmissions:
              userStates!.data.matchedUser.submitStats.acSubmissionNum[1].count,
          mediumSubmission:
              userStates!.data.matchedUser.submitStats.acSubmissionNum[2].count,
          hardSubmissions:
              userStates!.data.matchedUser.submitStats.acSubmissionNum[3].count,
          submissions: userStates!
              .data.matchedUser.submitStats.acSubmissionNum[0].submissions));

      result.fold((l) => emit(prevState.copyWith(l.message)),
          (r) => emit(CompleteProfileDoneState()));
    });
  }
}
