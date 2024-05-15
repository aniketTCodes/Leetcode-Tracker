import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/repository/problem_list_repository.dart';
import 'package:meta/meta.dart';

part 'problem_list_event.dart';
part 'problem_list_state.dart';

class ProblemListBloc extends Bloc<ProblemListEvent, ProblemListState> {
  final ProblemListRepository repo = getIt<ProblemListRepository>();
  ProblemListBloc() : super(ProblemListInitial()) {
    on<LoadProblemLists>((event, emit) => _loadProblemList(event, emit));
    on<CreateNewProblemListEvent>(
      (event, emit) => _onCreateNewListEvent(event, emit),
    );
    on<DeleteProblemList>(
      (event, emit) => _deleteProblemList(event, emit),
    );
  }

  _loadProblemList(
      LoadProblemLists event, Emitter<ProblemListState> emit) async {
    final result = await repo.getProblemLists();
    result.fold(
        (l) => emit(
              ProblemListErrorState(
                errorMessage: l.message,
              ),
            ),
        (r) => emit(ProblemListLoaded(
              lists: r,
            )));
  }

  _onCreateNewListEvent(
      CreateNewProblemListEvent event, Emitter<ProblemListState> emit) async {
    final prevState = state as ProblemListLoaded;
    if (event.title.isEmpty) {
      emit(prevState.copyWith(emptyProblemListTitleMessage));
      return;
    }

    if (event.description.isEmpty) {
      emit(prevState.copyWith(emptyProblemListDescriptionMessage));
      return;
    }

    if (prevState.lists
        .where((element) => element.title == event.title)
        .isNotEmpty) {
      emit(prevState.copyWith(duplicateListTitleErrorMessage));
      return;
    }

    final model = ProblemListModel(
        title: event.title,
        description: event.description,
        createdOn: DateTime.now().toString(),
        solved: 0,
        total: 0);

    final problemListResult = await repo.createNewProblemList(model);
    problemListResult.fold((l) => emit(prevState.copyWith(l.message)), (r) {
      final list = prevState.lists;
      list.add(model);
      emit(ProblemListLoaded(
        lists: list,
      ));
    });
  }

  _deleteProblemList(
      DeleteProblemList event, Emitter<ProblemListState> emit) async {
    final prevState = state as ProblemListLoaded;
    final deleteResult = await repo.deleteProblemList(event.title);
    deleteResult.fold(
        (l) => emit(prevState.copyWith(l.message)),
        (r) => emit(ProblemListLoaded(
            lists: prevState.lists
                .where((element) => element.title != event.title)
                .toList())));
  }
}
