import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:leetcode_tracker/features/dashboard/data/service/dashboard_service.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/service/leetcode_service.dart';

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
}
