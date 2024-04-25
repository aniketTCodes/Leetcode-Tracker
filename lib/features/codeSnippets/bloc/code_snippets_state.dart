part of 'code_snippets_bloc.dart';

@immutable
sealed class CodeSnippetsState {}

final class CodeSnippetsLoading extends CodeSnippetsState {}

final class CodeSnippetsDone extends CodeSnippetsState{
   final List<String> urls;

  CodeSnippetsDone({required this.urls});
}

final class CodeSnippetsError extends CodeSnippetsState{
  final String errorMessage;
  CodeSnippetsError({required this.errorMessage});
}