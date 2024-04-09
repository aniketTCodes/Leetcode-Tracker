part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardLoadingState extends DashboardState {}

final class DashboardDoneState extends DashboardState {
  final LeetcodeDataModel userState;

  DashboardDoneState({ required this.userState});
}

final class DashboardErrorStat extends DashboardState{
  final String errorMessage;

  DashboardErrorStat({required this.errorMessage});

}
