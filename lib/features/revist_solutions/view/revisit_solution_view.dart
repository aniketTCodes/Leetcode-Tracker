import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/codeSnippets/bloc/code_snippets_bloc.dart';
import 'package:leetcode_tracker/features/revist_solutions/view/revisit_solution_done_view.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'dart:developer' as dev show log;

class RevisitSolutionview extends StatelessWidget {
  static const route = '/revisitSolution';
  const RevisitSolutionview({super.key});

  @override
  Widget build(BuildContext context) {
    final SolutionModel solution =
        ModalRoute.of(context)!.settings.arguments as SolutionModel;
    return BlocProvider(
      create: (context) => CodeSnippetsBloc()
        ..add(LoadCodeSnippets(titleSlug: solution.titleSlug)),
      child: BlocConsumer<CodeSnippetsBloc, CodeSnippetsState>(
        builder: (context, state) {
          if (state is CodeSnippetsDone) {
            dev.log(state.urls.toString());
            return RevisitSolutionDoneView(solution: solution,urls:state.urls);
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
        listener: (context, state) {},
      ),
    );
  }
}
