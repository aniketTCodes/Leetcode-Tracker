part of 'complete_profile_bloc.dart';

@immutable
sealed class CompleteProfileState {}

final class CompleteProfileInitial extends CompleteProfileState {
  final bool hasErrors;
  final String? errorMessage;

  CompleteProfileInitial({this.errorMessage, this.hasErrors = false});
}

final class CompleteProfileLoadingState extends CompleteProfileState {}

final class CompleteProfileErrorState extends CompleteProfileState {}
