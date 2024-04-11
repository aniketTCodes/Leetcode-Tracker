part of 'solution_bloc.dart';

@immutable
sealed class SolutionState {}

class SolutionLoadingState extends SolutionState {}

class SolutionSearchState extends SolutionState {
  final List<Question> questions;
  final bool hasErrors;
  final String? errorMessage;

  SolutionSearchState(
      {required this.questions, this.hasErrors = false, this.errorMessage});

  SolutionSearchState copyWith(String message) {
    return SolutionSearchState(
        questions: questions, hasErrors: true, errorMessage: message);
  }
}

class SolutionAddEditState extends SolutionState {
  final Question question;
  final String? intuition;
  final String? approach;
  final String? complexity;
  final bool hasErrors;
  final String? errorMessage;

  SolutionAddEditState(
      {required this.question,
      this.intuition,
      this.approach,
      this.complexity,
      this.hasErrors = false,
      this.errorMessage});

  SolutionAddEditState copyWith(String message) {
    return SolutionAddEditState(
        question: question,
        intuition: intuition,
        approach: approach,
        complexity: complexity,
        hasErrors: true,
        errorMessage: message);
  }
}

class SolutionErrorState extends SolutionState{
  final String errorMessage;

  SolutionErrorState({required this.errorMessage});

}
