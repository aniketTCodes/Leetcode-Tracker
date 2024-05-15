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
  final String title;

  DeleteProblemList({required this.title});
}