import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/complete_profile/bloc/bloc/complete_profile_bloc.dart';
import 'package:leetcode_tracker/features/complete_profile/view/complete_profile.dart';
import 'package:leetcode_tracker/features/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:leetcode_tracker/features/home/view/home_view.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/revist_solutions/bloc/bloc/revisit_solution_bloc.dart';

class CompleteProfileView extends StatelessWidget {
  static const route = '/completeProfile';
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompleteProfileBloc()..add(CompleteProfileInitEvent()),
      child: BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
        builder: (context, state) {
          if (state is CompleteProfileInitial) {
            return const CompleteProfile();
          }

          return const Scaffold(
            backgroundColor: matteBlack,
            body: Center(
              child: CircularProgressIndicator(
                color: appYellow,
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is CompleteProfileDoneState) {
            context.read<DashboardBloc>().add(InitDashBoardEvent());
            context.read<ProblemListBloc>().add(LoadProblemLists());
            context.read<RevisitSolutionBloc>().add(GetUserSolutionEvent());
            Navigator.of(context).popAndPushNamed(HomeView.route);
          }
          if (state is CompleteProfileInitial && state.hasErrors) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ));
          }
        },
      ),
    );
  }
}
