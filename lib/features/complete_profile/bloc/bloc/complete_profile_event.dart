part of 'complete_profile_bloc.dart';

@immutable
sealed class CompleteProfileEvent {}

final class CompleteProfileInitEvent extends CompleteProfileEvent {}

final class CompleteProfileSaveEvent extends CompleteProfileEvent {
  final String displayName;
  final String username;

  CompleteProfileSaveEvent({
    required this.username,
    required this.displayName,
  });
}
