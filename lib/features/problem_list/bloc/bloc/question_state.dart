part of 'question_bloc.dart';

@immutable
sealed class QuestionState {}

final class QuestionLoadedState extends QuestionState{
  final List<Question> quesitons;
  final bool hasErrors;
  final String? errorMessage;
  QuestionLoadedState({required this.quesitons,this.hasErrors = false,this.errorMessage});
}

final class QuestionLoadingState extends QuestionState{

}

final class QuestionErrorState extends QuestionState{}
