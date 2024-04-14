import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/solutions/view/search_question_view.dart';

class SolutionView extends StatelessWidget {
  static const route = '/solution';
  const SolutionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolutionBloc, SolutionState>(
      builder: (context, state) {
        if (state is SolutionSearchState) {
          return SearchQuestionView(
              questions: state.questions, loadingMessage: state.loadingMessage);
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
        if (state is SolutionSearchState && state.hasErrors) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: const Color.fromARGB(255, 237, 78, 29),
          ));
        }
      },
    );
  }
}
