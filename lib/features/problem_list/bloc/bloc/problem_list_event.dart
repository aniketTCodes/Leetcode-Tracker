part of 'problem_list_bloc.dart';

@immutable
sealed class ProblemListEvent {}

class LoadProblemLists extends ProblemListEvent{}

class CreateNewProblemListEvent extends ProblemListEvent{
  final String title;
  final String description;

  CreateNewProblemListEvent({required this.title, required this.description});
}

class DeleteProblemList extends ProblemListEvent{
  final String id;

  DeleteProblemList({required this.id});
}

class EditProblemListEvent extends ProblemListEvent{
  final ProblemListModel model;

  EditProblemListEvent({required this.model});
}

class AddQuestionEvent extends ProblemListEvent{
  final String problemListId;
  final Question question;

  AddQuestionEvent({required this.question,required this.problemListId});
}