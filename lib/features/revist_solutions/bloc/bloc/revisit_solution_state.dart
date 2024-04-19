part of 'revisit_solution_bloc.dart';

@immutable
sealed class RevisitSolutionState {}

final class RevisitLoadingState extends RevisitSolutionState {}

final class RevisitSolutionsLoadedState extends RevisitSolutionState{
  final List<SolutionModel> solutions;

  RevisitSolutionsLoadedState({required this.solutions});
}

final class RevisitSolutionErrorState extends RevisitSolutionState{
   final String errorMessage;

  RevisitSolutionErrorState({required this.errorMessage});
}
