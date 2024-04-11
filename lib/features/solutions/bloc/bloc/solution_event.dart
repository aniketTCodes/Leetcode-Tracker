part of 'solution_bloc.dart';

@immutable
sealed class SolutionEvent {}

final class SolutionInitEvent extends SolutionEvent{
  final Question? question;

  SolutionInitEvent({this.question});
}
