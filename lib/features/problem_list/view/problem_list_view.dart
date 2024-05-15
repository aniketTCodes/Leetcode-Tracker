import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/core/painter/background_painter.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/view/select_question_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProblemListView extends StatefulWidget {
  static const String route = '/problemList';
  const ProblemListView({super.key});

  @override
  State<ProblemListView> createState() => _ProblemListViewState();
}

class _ProblemListViewState extends State<ProblemListView> {
  @override
  Widget build(BuildContext context) {
    final ProblemListModel model =
        ModalRoute.of(context)!.settings.arguments as ProblemListModel;
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            backgroundColor: matteBlack,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SelectQuestionDialogueView(),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: appYellow,
                ),
                Text(
                  'Add Question',
                  style: TextStyle(color: appYellow),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: matteBlack,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                model.title,
                                style: const TextStyle(
                                  color: appYellow,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  fontFamily: 'NotoSerif',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<ProblemListBloc>().add(
                                      DeleteProblemList(title: model.title));
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: accentBlack,
                                      title: const Text(
                                        'Are you sure',
                                        style: TextStyle(color: appYellow),
                                      ),
                                      content: Text(
                                        'Problem list ${model.title} and all questions in list will be deleted, are you sure?',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.read<ProblemListBloc>().add(
                                                DeleteProblemList(
                                                    title: model.title));
                                            Navigator.of(context).popUntil(
                                              (route) => route.isFirst,
                                            );
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: appYellow,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'No',
                                            style: TextStyle(
                                              color: appYellow,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: appYellow,
                                ),
                              )
                            ],
                          ),
                          Text(
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            model.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 8,
                          progressColor: appYellow,
                          percent:
                              model.total != 0 ? model.solved / model.total : 0,
                          center: Text(
                            "${model.solved}/${model.total}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
