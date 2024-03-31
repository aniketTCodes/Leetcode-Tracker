import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:meta/meta.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileLoadingState()) {
    on<CompleteProfileInitEvent>((event, emit) {
      final user = getIt<FirebaseAuth>().currentUser;
      if (user == null) {
        emit(CompleteProfileErrorState());
        return;
      }

      emit(CompleteProfileInitial());
    });
  }
}
