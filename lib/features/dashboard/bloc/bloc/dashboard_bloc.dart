import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:leetcode_tracker/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repo = getIt<DashboardRepository>();
  DashboardBloc() : super(DashboardLoadingState()) {
    on<InitDashBoardEvent>((event, emit) => initializeDashBoard(event, emit));
  }

  initializeDashBoard(
      InitDashBoardEvent event, Emitter<DashboardState> emit) async {
    final result = await repo.getLeetcodeStats();
    result.fold(
      (l) => {
        emit(
          DashboardErrorStat(
            errorMessage: l.message,
          ),
        ),
      },
      (r) => {
        emit(
          DashboardDoneState(
            userState: r,
          ),
        )
      },
    );
  }
}
