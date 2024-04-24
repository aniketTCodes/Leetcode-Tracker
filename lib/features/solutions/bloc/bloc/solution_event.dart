part of 'solution_bloc.dart';

@immutable
sealed class SolutionEvent {}

final class SolutionInitEvent extends SolutionEvent {
  final Question? question;

  SolutionInitEvent({this.question});
}

final class SearchQuestionEvent extends SolutionEvent {
  final String searchKeyword;

  SearchQuestionEvent({required this.searchKeyword});
}

final class OnQuesitonSelectEvent extends SolutionEvent {
  final Question question;

  OnQuesitonSelectEvent({required this.question});
}

final class SaveSolutionEvent extends SolutionEvent {
  final Question question;
  final String problemGoal;
  final String optimization;
  final String rationale;
  final List<TagModel> tags;
  final List<Uint8List> codeSnippets;

  SaveSolutionEvent(
      {required this.question,
      required this.problemGoal,
      required this.optimization,
      required this.rationale,
      required this.tags,
      required this.codeSnippets
      });
}

final class AddTagEvent extends SolutionEvent{
   final TagModel tag;

  AddTagEvent({required this.tag});

}
