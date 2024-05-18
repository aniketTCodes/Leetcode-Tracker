import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_question_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/repository/problem_list_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
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
    on<EditProblemListEvent>(
      (event, emit) => _editProblemList(event, emit),
    );
    on<AddQuestionEvent>((event, emit) => _addQuestion(event, emit));
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
        id: " ",
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
    final deleteResult = await repo.deleteProblemList(event.id);
    deleteResult.fold(
        (l) => emit(prevState.copyWith(l.message)),
        (r) => emit(ProblemListLoaded(
            lists: prevState.lists
                .where((element) => element.id != event.id)
                .toList())));
  }

  _editProblemList(
      EditProblemListEvent event, Emitter<ProblemListState> emit) async {
    final prevstate = state as ProblemListLoaded;
    emit(ProblemListInitial());
    final prevModel = prevstate.lists
        .where((element) => element.id == event.model.id)
        .toList();
    if (identical(prevModel[0], event.model)) {
      return;
    }
    final editResult = await repo.editProblemList(event.model);
    editResult.fold((l) => emit(prevstate.copyWith(l.message)), (r) {
      int index = prevstate.lists.indexOf(prevModel[0]);
      prevstate.lists[index] = event.model;
      emit(prevstate);
    });
  }

  _addQuestion(AddQuestionEvent event, Emitter<ProblemListState> emit) async {
    final prevState = state as ProblemListLoaded;
    emit(ProblemListInitial());
    await repo.addQuestion(
        event.problemListId,
        ProblemListQuestionModel(
            solved: false, quesiton: event.question, id: ''));
  }
}
