import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/complete_profile/data/model/profile_data.dart';
import 'package:leetcode_tracker/features/complete_profile/data/repository/complete_profile_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:meta/meta.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final FirebaseAuth _auth = getIt<FirebaseAuth>();
  final repo = CompleteProfileRepository();
  CompleteProfileBloc() : super(CompleteProfileLoadingState()) {
    on<CompleteProfileInitEvent>((event, emit) {
      final user = getIt<FirebaseAuth>().currentUser;
      if (user == null) {
        emit(CompleteProfileErrorState());
        return;
      }

      emit(CompleteProfileInitial());
    });
    on<CompleteProfileSaveEvent>((event, emit) async {
      final prevState = state as CompleteProfileInitial;
      emit(CompleteProfileLoadingState());
      final user = _auth.currentUser;
      if (user == null) {
        emit(CompleteProfileErrorState());
        return;
      }
      final result = await repo.storeCompleteProfileData(ProfileData(
          displayName: event.displayName,
          email: event.email,
          acSubmissions: event.acSubmissions,
          easySubmissions: event.easySubmissions,
          mediumSubmission: event.mediumSubmission,
          hardSubmissions: event.hardsubmissions,
          submissions: event.submissions));

      result.fold((l) => emit(prevState.copyWith(l.message)),
          (r) => emit(CompleteProfileDoneState()));
    });
  }
}
