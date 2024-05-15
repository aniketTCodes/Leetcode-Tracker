import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:leetcode_tracker/features/codeSnippets/data/repository/code_snippet_repository.dart';
import 'package:leetcode_tracker/features/codeSnippets/data/service/code_snippets_service.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:leetcode_tracker/features/dashboard/data/service/dashboard_service.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/service/leetcode_service.dart';
import 'package:leetcode_tracker/features/problem_list/data/repository/problem_list_repository.dart';
import 'package:leetcode_tracker/features/problem_list/data/service/problem_list_service.dart';
import 'package:leetcode_tracker/features/revist_solutions/data/repository/revisit_solution_repository.dart';
import 'package:leetcode_tracker/features/revist_solutions/data/revisit_solution_service.dart';
import 'package:leetcode_tracker/features/solutions/data/repository/solution_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/service/solution_service.dart';
import 'package:leetcode_tracker/features/tags/data/repository/tag_repository.dart';
import 'package:leetcode_tracker/features/tags/data/service/tags_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<LeetcodeService>(() => LeetcodeService());
  getIt.registerLazySingleton<LeetcodeRespository>(
      () => LeetcodeRespository(service: getIt<LeetcodeService>()));

  getIt.registerLazySingleton<DashboardService>(() => DashboardServiceImpl());
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepository(service: getIt<DashboardService>()));
  getIt.registerLazySingleton<SolutionService>(() => SolutionServiceImpl());
  getIt.registerLazySingleton<SolutionRepository>(
      () => SolutionRepository(service: getIt<SolutionService>()));
  getIt.registerLazySingleton<TagService>(() => TagServiceImpl());
  getIt.registerLazySingleton<TagRepository>(
      () => TagRepository(service: getIt<TagService>()));

  getIt.registerLazySingleton<RevisitSolutionService>(
      () => RevisitSolutionService());
  getIt.registerLazySingleton<RevisitSolutionRepository>(() =>
      RevisitSolutionRepository(service: getIt<RevisitSolutionService>()));
  getIt.registerLazySingleton<CodeSnippetsService>(() => CodeSnippetsService());
  getIt.registerLazySingleton<CodeSnippetsRepository>(
      () => CodeSnippetsRepository(service: getIt<CodeSnippetsService>()));

  getIt.registerLazySingleton<ProblemListService>(() => ProblemListServiceImpl());
  getIt.registerLazySingleton(() => ProblemListRepository(service: getIt<ProblemListService>()));
}
