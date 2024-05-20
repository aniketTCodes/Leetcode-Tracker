part of 'question_list_bloc.dart';

@immutable
sealed class QuestionListEvent {}

final class LoadQuestionEvent extends QuestionListEvent{
  final String problemListTitle;

  LoadQuestionEvent({required this.problemListTitle});
}

final class AddQuestionEvent extends QuestionListEvent{
  final String problemListId;
  final Question question;

  AddQuestionEvent({required this.question,required this.problemListId});
}

final class MarkDoneEvent extends QuestionListEvent{
  final String problemListId;
  final String titleSlug;
  final bool mark;

  MarkDoneEvent({required this.problemListId, required this.titleSlug,required this.mark});
}

final class DeleteQuesitonEvent extends QuestionListEvent{
  final String problemListId;
   final String titleSlug;

  DeleteQuesitonEvent({required this.problemListId, required this.titleSlug});
}