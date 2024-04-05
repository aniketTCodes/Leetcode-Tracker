part of 'complete_profile_bloc.dart';

@immutable
sealed class CompleteProfileEvent {}

final class CompleteProfileInitEvent extends CompleteProfileEvent {}

final class CompleteProfileSaveEvent extends CompleteProfileEvent {
  final String displayName;
  final String email;
  final int acSubmissions;
  final int easySubmissions;
  final int mediumSubmission;
  final int hardsubmissions;
  final int submissions;

  CompleteProfileSaveEvent(
      {required this.displayName,
      required this.email,
      required this.acSubmissions,
      required this.easySubmissions,
      required this.mediumSubmission,
      required this.hardsubmissions,
      required this.submissions});
}
