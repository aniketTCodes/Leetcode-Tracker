import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:meta/meta.dart';
part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final LeetcodeRespository repo = getIt<LeetcodeRespository>();
  QuestionBloc() : super(QuestionLoadedState(quesitons: const [])) {
    on<SearchQuestionEvent>((event, emit) => _searchQuestions(event, emit));
  }

  _searchQuestions(
      SearchQuestionEvent event, Emitter<QuestionState> emit) async {
    emit(QuestionLoadingState());
    final searchResult = await repo.getProblemSet(event.searchKeyword, 5);
    searchResult.fold(
        (l) => emit(QuestionErrorState()),
        (r) => emit(QuestionLoadedState(
            quesitons: r.data.problemsetQuestionList.questions)));
  }
}
