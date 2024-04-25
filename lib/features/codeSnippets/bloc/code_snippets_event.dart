part of 'code_snippets_bloc.dart';

@immutable
sealed class CodeSnippetsEvent {}

final class LoadCodeSnippets extends CodeSnippetsEvent {
  final String titleSlug;

  LoadCodeSnippets({required this.titleSlug});
}
