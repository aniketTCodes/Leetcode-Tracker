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
  }

  _loadQuestionList(
      LoadQuestionEvent event, Emitter<QuestionListState> emit) async {
    final getQuestionsResult =
        await repo.getProblemListQuestions(event.problemListTitle);
    getQuestionsResult.fold(
        (l) => emit(QuestionListErrorState(errorMessage: l.message)),
        (r) => emit(QuestionListLoadedState(questions: r)));
  }
}
