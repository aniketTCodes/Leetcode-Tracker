part of 'question_list_bloc.dart';

@immutable
sealed class QuestionListEvent {}

final class LoadQuestionEvent extends QuestionListEvent{
  final String problemListTitle;

  LoadQuestionEvent({required this.problemListTitle});
}
