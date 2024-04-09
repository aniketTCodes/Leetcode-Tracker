part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class InitDashBoardEvent extends DashboardEvent{

}
class UpdateUserStatsEvent extends DashboardEvent{}
