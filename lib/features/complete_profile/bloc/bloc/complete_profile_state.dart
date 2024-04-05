part of 'complete_profile_bloc.dart';

@immutable
sealed class CompleteProfileState {}

final class CompleteProfileInitial extends CompleteProfileState {
  final bool hasErrors;
  final String? errorMessage;

  CompleteProfileInitial({this.errorMessage, this.hasErrors = false});

  CompleteProfileInitial copyWith(String errorMessage) {
    return CompleteProfileInitial(hasErrors: true, errorMessage: errorMessage);
  }
}

final class CompleteProfileLoadingState extends CompleteProfileState {}

final class CompleteProfileErrorState extends CompleteProfileState {}

final class CompleteProfileDoneState extends CompleteProfileState{
  
}
