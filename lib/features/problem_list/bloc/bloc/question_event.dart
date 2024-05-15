part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent {}

final class SearchQuestionEvent extends QuestionEvent{
  final String searchKeyword;
   SearchQuestionEvent({required this.searchKeyword});
}
