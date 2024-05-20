import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/question_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_question_model.dart';
import 'package:leetcode_tracker/features/problem_list/data/repository/problem_list_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:meta/meta.dart';

part 'question_list_event.dart';
part 'question_list_state.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  final repo = getIt<ProblemListRepository>();
  QuestionListBloc() : super(QuestionListLoadingState()) {
    on<LoadQuestionEvent>((event, emit) => _loadQuestionList(event, emit));
    on<AddQuestionEvent>((event, emit) => _addQuestion(event, emit));
    on<MarkDoneEvent>((event, emit) => _markDone(event, emit));
    on<DeleteQuesitonEvent>(
      (event, emit) => _deleteQuestion(event, emit),
    );
  }

  _loadQuestionList(
      LoadQuestionEvent event, Emitter<QuestionListState> emit) async {
    final getQuestionsResult =
        await repo.getProblemListQuestions(event.problemListTitle);
    getQuestionsResult.fold(
        (l) => emit(QuestionListErrorState(errorMessage: l.message)),
        (r) => emit(QuestionListLoadedState(questions: r)));
  }

  _addQuestion(AddQuestionEvent event, Emitter<QuestionListState> emit) async {
    final prevState = state as QuestionListLoadedState;
    final model =
        ProblemListQuestionModel(solved: false, quesiton: event.question);
    final addResult = await repo.addQuestion(event.problemListId, model);
    addResult.fold((l) => emit(prevState.copyWith(l.message)), (r) {
      if (!prevState.questions.contains(model)) {
        emit(
          QuestionListLoadedState(
            questions: prevState.questions + [model],
          ),
        );
      }
    });
  }

  _markDone(MarkDoneEvent event, Emitter<QuestionListState> emit) async {
    final prevState = state as QuestionListLoadedState;
    final markDoneResult =
        await repo.markDone(event.problemListId, event.titleSlug, event.mark);
    markDoneResult.fold(
      (l) => emit(prevState.copyWith(l.message)),
      (r) {
        final list = prevState.questions;
        final problemListModel = list
            .where((element) => element.quesiton.titleSlug == event.titleSlug)
            .toList()[0];
        final newList = ProblemListQuestionModel(
            solved: event.mark, quesiton: problemListModel.quesiton);
        emit(QuestionListLoadedState(
            questions: list
                    .where(
                      (element) =>
                          element.quesiton.titleSlug != event.titleSlug,
                    )
                    .toList() +
                [newList]));
      },
    );
  }

  _deleteQuestion(
      DeleteQuesitonEvent event, Emitter<QuestionListState> emit) async {
    final prevState = state as QuestionListLoadedState;
    final deleteResult =
        await repo.deleteQuestion(event.problemListId, event.titleSlug);
    deleteResult.fold((l) => emit(prevState.copyWith(l.message)), (r) {
      final list = prevState.questions;
      emit(QuestionListLoadedState(
          questions: list
              .where(
                (element) => element.quesiton.titleSlug != event.titleSlug,
              )
              .toList()));
    });
  }
}
