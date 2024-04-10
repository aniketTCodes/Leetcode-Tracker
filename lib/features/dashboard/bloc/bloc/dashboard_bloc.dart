import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:leetcode_tracker/features/leetcode_api/data/repository/leetcode_repository.dart';
import 'package:meta/meta.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repo = getIt<DashboardRepository>();
  final LeetcodeRespository leetcodeRepository = getIt<LeetcodeRespository>();
  DashboardBloc() : super(DashboardLoadingState()) {
    on<InitDashBoardEvent>((event, emit) => initializeDashBoard(event, emit));
  }

  initializeDashBoard(
      InitDashBoardEvent event, Emitter<DashboardState> emit) async {
    final result = await repo.getLeetcodeStats();
    LeetcodeDataModel? userStats;
    result.fold(
      (l) => {
        emit(
          DashboardErrorStat(
            errorMessage: l.message,
          ),
        ),
      },
      (r) => {userStats = r},
    );
    if (userStats == null) return;
    final leetcodeResult =
        await leetcodeRepository.fetchUserData(userStats!.displayName);
    leetcodeResult
        .fold((l) => {emit(DashboardDoneState(userState: userStats!))}, (r) {
      final leetcodeState = r.data.matchedUser.submitStats.acSubmissionNum;
      final submissions = leetcodeState[0].submissions;
      if (submissions != userStats!.submissions) {
        final easySubmissions = leetcodeState[1].count;
        final mediumSubmissions = leetcodeState[2].count;
        final hardSubmissions = leetcodeState[3].count;
        final acSubmissions = leetcodeState[0].count;
        LeetcodeDataModel model = LeetcodeDataModel(
            email: userStats!.email,
            username: userStats!.username,
            displayName: userStats!.displayName,
            submissions: submissions,
            acSubmissions: acSubmissions,
            easySubmissions: easySubmissions,
            mediumSubmissions: mediumSubmissions,
            hardSubmissions: hardSubmissions);
        emit(DashboardDoneState(userState: model));
        repo.updateLeetcodeStats(model);
      } else {
        emit(DashboardDoneState(userState: userStats!));
      }
    });
  }
}
