part of 'complete_profile_bloc.dart';

@immutable
sealed class CompleteProfileEvent {}

final class CompleteProfileInitEvent extends CompleteProfileEvent {}

final class CompleteProfileSaveEvent extends CompleteProfileEvent {
  final String displayName;

  CompleteProfileSaveEvent({
    required this.displayName,
  });
}
