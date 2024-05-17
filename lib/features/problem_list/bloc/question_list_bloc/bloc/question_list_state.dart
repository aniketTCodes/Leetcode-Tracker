part of 'question_list_bloc.dart';

@immutable
sealed class QuestionListState {}

final class QuestionListStateWithErrorState extends QuestionListState {
  final bool hasErrors;
  final String? errorMessage;

  QuestionListStateWithErrorState({this.hasErrors = false, this.errorMessage});

  QuestionListStateWithErrorState copyWith(String errorMessage) {
    return QuestionListStateWithErrorState(
        hasErrors: true, errorMessage: errorMessage);
  }
}

final class QuestionListLoadedState extends QuestionListStateWithErrorState {
  final List<ProblemListQuestionModel> questions;

  QuestionListLoadedState(
      {super.hasErrors, super.errorMessage, required this.questions});

  @override
  QuestionListLoadedState copyWith(String errorMessage) {
    return QuestionListLoadedState(
        questions: questions, hasErrors: true, errorMessage: errorMessage);
  }
}

final class QuestionListLoadingState extends QuestionListState {}

final class QuestionListErrorState extends QuestionListState{
  final String errorMessage;

  QuestionListErrorState({required this.errorMessage});
}
