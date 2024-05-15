import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/view/problem_list_view.dart';

class ProblemListLoadedView extends StatelessWidget {
  final List<ProblemListModel> problemLists;
  const ProblemListLoadedView({super.key, required this.problemLists});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ProblemListBloc>().add(LoadProblemLists());
            },
            child: ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProblemListView.route,
                      arguments: problemLists[index]);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: accentBlack,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            problemLists[index].title,
                            style: const TextStyle(
                              color: appYellow,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            problemLists[index].description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${problemLists[index].solved}/${problemLists[index].total}',
                        style: const TextStyle(
                          color: appYellow,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: problemLists.length,
            ),
          ),
        ),
      ],
    );
  }
}
