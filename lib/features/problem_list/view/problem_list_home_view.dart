import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/view/lists_view.dart';
import 'package:leetcode_tracker/features/problem_list/view/new_list_alert_dialogue.dart';

class ProblemListView extends StatelessWidget {
  const ProblemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: SizedBox(
          width: 120,
          child: FloatingActionButton(
            backgroundColor: matteBlack,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const NewListAlertDialogueView(),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_document,
                  color: appYellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'New List',
                  style: TextStyle(color: appYellow),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: matteBlack,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          title: const Text(
            'Problem Lists',
            style: TextStyle(
              color: appYellow,
            ),
          ),
        ),
        body: BlocConsumer<ProblemListBloc, ProblemListState>(
          builder: (context, state) {
            if (state is ProblemListLoaded) {
              return ProblemListLoadedView(problemLists: state.lists);
            }
            if (state is ProblemListErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: accentBlack,
              ),
            );
          },
          listener: (context, state) {
            if (state is ProblemListLoaded && state.hasErrors) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ));
            }
          },
        ));
  }
}
