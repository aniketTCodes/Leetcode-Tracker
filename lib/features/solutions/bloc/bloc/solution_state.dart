part of 'solution_bloc.dart';

@immutable
sealed class SolutionState {}

class SolutionLoadingState extends SolutionState {}

class SolutionSearchState extends SolutionState {
  final List<Question>? questions;
  final bool hasErrors;
  final String? errorMessage;
  final String loadingMessage;

  SolutionSearchState(
      {required this.questions,
      this.hasErrors = false,
      this.errorMessage,
      required this.loadingMessage});

  SolutionSearchState copyWith(String message) {
    return SolutionSearchState(
        questions: questions,
        hasErrors: true,
        errorMessage: message,
        loadingMessage: loadingMessage);
  }
}

class SolutionErrorState extends SolutionState {
  final String errorMessage;

  SolutionErrorState({required this.errorMessage});
}

class SolutionAddEditState extends SolutionState {
  final Question question;
  final SolutionModel? solution;
  final List<Uint8List>? codeSnippets;
  final bool hasErrors;
  final String? errorMessage;

  SolutionAddEditState({
    required this.question,
    this.solution,
    this.hasErrors = false,
    this.errorMessage,
    this.codeSnippets,
  });
  SolutionAddEditState copyWith(String errorMessage) {
    return SolutionAddEditState(
        question: question,
        solution: solution,
        hasErrors: true,
        codeSnippets: codeSnippets,
        errorMessage: errorMessage);
  }
}

class SolutionDoneState extends SolutionState {}
