part of 'problem_list_bloc.dart';

@immutable
sealed class ProblemListState {}

final class ProblemListInitial extends ProblemListState {}

final class ProblemListLoaded extends ProblemListState {
  final List<ProblemListModel> lists;
  final bool hasErrors;
  final String? errorMessage;

  ProblemListLoaded(
      {required this.lists, this.hasErrors = false, this.errorMessage});

  ProblemListLoaded copyWith(String errorMessage) {
    return ProblemListLoaded(
        lists: lists, hasErrors: true, errorMessage: errorMessage);
  }
}

final class ProblemListErrorState extends ProblemListState{
  final String errorMessage;

  ProblemListErrorState({required this.errorMessage});

}
