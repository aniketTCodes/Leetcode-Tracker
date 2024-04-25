import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/codeSnippets/data/repository/code_snippet_repository.dart';
import 'package:meta/meta.dart';

part 'code_snippets_event.dart';
part 'code_snippets_state.dart';

class CodeSnippetsBloc extends Bloc<CodeSnippetsEvent, CodeSnippetsState> {
  final CodeSnippetsRepository repository = getIt<CodeSnippetsRepository>();
  CodeSnippetsBloc() : super(CodeSnippetsLoading()) {
    on<LoadCodeSnippets>(
      (event, emit) => _onLoadCodeSnippets(event, emit),
    );
  }

  _onLoadCodeSnippets(
      LoadCodeSnippets event, Emitter<CodeSnippetsState> emit) async {
    final codeSnippetsUrlsResult =
        await repository.getCodeSnippetsUrl(event.titleSlug);
    codeSnippetsUrlsResult.fold(
        (l) => emit(CodeSnippetsError(errorMessage: l.message)),
        (r) => emit(CodeSnippetsDone(urls: r)));
  }
}
