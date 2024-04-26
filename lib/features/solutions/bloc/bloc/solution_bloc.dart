import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leetcode_tracker/core/constants/errors.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:leetcode_tracker/features/solutions/data/models/recent_ac_model.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'package:leetcode_tracker/features/solutions/data/repository/solution_repository.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as dev show log;
part 'solution_event.dart';
part 'solution_state.dart';

class SolutionBloc extends Bloc<SolutionEvent, SolutionState> {
  final DashboardRepository dashboardRepository;
  final FirebaseAuth firebaseAuth;
  final LeetcodeRespository leetcodeRespository;
  final SolutionRepository solutionRepository;

  SolutionBloc(
      {required this.dashboardRepository,
      required this.firebaseAuth,
      required this.leetcodeRespository,
      required this.solutionRepository})
      : super(SolutionLoadingState()) {
    on<SolutionInitEvent>((event, emit) => _initEvent(event, emit));
    on<SearchQuestionEvent>(
      (event, emit) => _searchQuestionsEvent(event, emit),
    );
    on<OnQuesitonSelectEvent>(
      (event, emit) => _onSelectQuesitionEvent(event, emit),
    );
    on<SaveSolutionEvent>(
      (event, emit) => _onSaveSolutionEvent(event, emit),
    );
    on<AddTagEvent>(
      (event, emit) => onAddTagEvent(event, emit),
    );
  }

  _initEvent(SolutionInitEvent event, Emitter<SolutionState> emit) async {
    //final String uid = firebaseAuth.currentUser!.uid;
    if (event.question == null) {
      emit(SolutionSearchState(
          questions: null, loadingMessage: 'Fetching recent submissions'));
      final questions = await _getQuestionsFromRecentAc();
      if (questions == null) return;
      emit(SolutionSearchState(questions: questions, loadingMessage: ''));
    } else {
      //HANDLE EDIT SOLUTION FLOW
    }
  }

  Future<List<Question>?> _getQuestionsFromRecentAc() async {
    final leetcodeDataResult = await dashboardRepository.getLeetcodeStats();
    LeetcodeDataModel? leetcodeDataModel;
    leetcodeDataResult.fold(
      (l) => dev.log(l.message),
      (r) {
        leetcodeDataModel = r;
      },
    );
    if (leetcodeDataModel == null) return null;
    final String username = leetcodeDataModel!.displayName;

    final recentAcModelResult =
        await leetcodeRespository.getRecentAcSubmissions(username);
    RecentAcModel? recentAcModel;
    recentAcModelResult.fold(
      (l) => dev.log(l.message),
      (r) => recentAcModel = r,
    );
    if (recentAcModel == null) return null;

    final List<String> searchKeywords =
        recentAcModel!.data.recentAcSubmissionList.map((e) => e.title).toList();
    final List<Question> questions = [];
    for (String searchKeyword in searchKeywords) {
      final problemSetModelResult =
          await leetcodeRespository.getProblemSet(searchKeyword, 1);
      ProblemSetModel? problemSetModel;
      problemSetModelResult.fold(
          (l) => dev.log(l.message), (r) => problemSetModel = r);
      if (problemSetModel == null) return null;
      questions.add(problemSetModel!.data.problemsetQuestionList.questions[0]);
    }
    return questions;
  }

  _searchQuestionsEvent(
      SearchQuestionEvent event, Emitter<SolutionState> emit) async {
    final prevState = state as SolutionSearchState;
    if (event.searchKeyword.isEmpty) {
      emit(prevState.copyWith(emptySearchKeywordErrorMessage));
      return;
    }
    emit(SolutionSearchState(questions: null, loadingMessage: 'Searching...'));
    final problemSetResult =
        await leetcodeRespository.getProblemSet(event.searchKeyword, 10);
    ProblemSetModel? problemSet;
    problemSetResult.fold(
        (l) => {prevState.copyWith(l.message)}, (r) => problemSet = r);

    if (problemSet == null) return;
    emit(SolutionSearchState(
        questions: problemSet!.data.problemsetQuestionList.questions,
        loadingMessage: ''));
  }

  _onSelectQuesitionEvent(
      OnQuesitonSelectEvent event, Emitter<SolutionState> emit) async {
    final prevState = state as SolutionSearchState;
    emit(SolutionLoadingState());
    final hasSolutionResult =
        await solutionRepository.hasSolution(event.question.titleSlug);
    bool? hasSolution;
    hasSolutionResult.fold(
        (l) => {emit(prevState.copyWith(l.message))}, (r) => hasSolution = r);
    if (hasSolution == null) return;
    if (hasSolution == false) {
      emit(SolutionAddEditState(question: event.question));
    } else {
      final getSolutionResult =
          await solutionRepository.getSolution(event.question.titleSlug);
      final imageUrlsResult =
          await solutionRepository.getImageUrls(event.question.titleSlug);
      List<Uint8List> imageUrls = [];
      imageUrlsResult.fold(
          (l) => {emit(prevState.copyWith(l.message))}, (r) => imageUrls = r);
      SolutionModel? solution;
      getSolutionResult.fold(
          (l) => {emit(prevState.copyWith(l.message))}, (r) => solution = r);
      if (solution == null) return;
      emit(SolutionAddEditState(
          question: event.question,
          solution: solution,
          codeSnippets: imageUrls));
    }
  }

  _onSaveSolutionEvent(
      SaveSolutionEvent event, Emitter<SolutionState> emit) async {
    final prevState = state as SolutionAddEditState;
    if (event.problemGoal.isEmpty ||
        event.optimization.isEmpty ||
        event.rationale.isEmpty) {
      emit(prevState.copyWith(emptySolutionFieldErrorMessage));
      return;
    }
    emit(SolutionLoadingState());
    final addSolutionResult = await solutionRepository.setSolution(
        SolutionModel(
            titleSlug: event.question.titleSlug,
            questionTitle: event.question.title,
            difficulty: event.question.difficulty,
            problemGoal: event.problemGoal,
            optimization: event.optimization,
            rationale: event.rationale,
            tags: event.tags),
        event.question.titleSlug);
    await solutionRepository.putCodeSnippets(
        event.codeSnippets, event.question.titleSlug);
    addSolutionResult.fold((l) => emit(prevState.copyWith(l.message)),
        (r) => emit(SolutionDoneState()));
  }

  onAddTagEvent(AddTagEvent event, Emitter<SolutionState> emit) {
    final prevState = state as SolutionAddEditState;
    emit(SolutionLoadingState());
    emit(SolutionAddEditState(
        question: prevState.question,
        solution: prevState.solution == null
            ? SolutionModel(
                titleSlug: prevState.question.titleSlug,
                questionTitle: prevState.question.title,
                difficulty: prevState.question.difficulty,
                problemGoal: "",
                optimization: "",
                rationale: "",
                tags: [event.tag])
            : SolutionModel(
                titleSlug: prevState.question.titleSlug,
                questionTitle: prevState.solution!.questionTitle,
                difficulty: prevState.solution!.difficulty,
                problemGoal: prevState.solution!.problemGoal,
                optimization: prevState.solution!.optimization,
                rationale: prevState.solution!.rationale,
                tags: [event.tag] + prevState.solution!.tags)));
  }
}
