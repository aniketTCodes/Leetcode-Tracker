part of 'question_bloc.dart';

@immutable
sealed class QuestionState {}

final class QuestionLoadedState extends QuestionState{
  final List<Question> quesitons;
  QuestionLoadedState({required this.quesitons});
}

final class QuestionLoadingState extends QuestionState{

}

final class QuestionErrorState extends QuestionState{}
