part of 'tags_bloc.dart';

@immutable
sealed class TagsState {}

final class TagLoadingState extends TagsState {}

final class TagDoneState extends TagsState{
  final List<TagModel> tags;

  TagDoneState({required this.tags});
}

final class TagErrorState extends TagsState{
  final String errorMessage;

  TagErrorState({required this.errorMessage});
}
