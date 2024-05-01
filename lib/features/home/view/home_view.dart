import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/core/painter/background_painter.dart';
import 'package:leetcode_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:leetcode_tracker/features/auth/view/auth_view.dart';
import 'package:leetcode_tracker/features/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:leetcode_tracker/features/dashboard/view/dashboard_view.dart';
import 'package:leetcode_tracker/features/revist_solutions/bloc/bloc/revisit_solution_bloc.dart';
import 'package:leetcode_tracker/features/revist_solutions/view/revisit_solution_home_view.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/solutions/view/solution_view.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchKeywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: matteBlack,
          onPressed: () {
            context.read<SolutionBloc>().add(SolutionInitEvent());
            Navigator.pushNamed(context, SolutionView.route);
          },
          child: const Icon(
            Icons.add,
            color: appYellow,
          ),
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: matteBlack,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.of(context).popAndPushNamed(AuthView.route);
                },
                icon: const Icon(
                  Icons.logout,
                  color: appYellow,
                ))
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              BlocConsumer<DashboardBloc, DashboardState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is DashboardDoneState) {
                    return DashboardView(
                        name: state.userState.username,
                        userState: state.userState);
                  }
                  return const DashboardView(
                    name: 'John Doe',
                    userState: null,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) =>
                    RevisitSolutionBloc()..add(GetUserSolutionEvent()),
                child: BlocConsumer<RevisitSolutionBloc, RevisitSolutionState>(
                  builder: (context, state) {
                    if (state is RevisitSolutionsLoadedState) {
                      final solutionList = state.solutions;
                      return RevisitSolutionHomeView(solutions: solutionList);
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: matteBlack,
                      ),
                    );
                  },
                  listener: (context, state) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
