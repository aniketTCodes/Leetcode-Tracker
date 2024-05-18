import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/core/painter/background_painter.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/question_list_bloc/bloc/question_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/view/edit_list_dialogue.dart';
import 'package:leetcode_tracker/features/problem_list/view/select_question_view.dart';
import 'package:leetcode_tracker/features/solutions/view/search_question_view.dart';

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
    final createdOn = DateTime.parse(model.createdOn);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: matteBlack,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: const TextStyle(
                            color: appYellow,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${getMonthName(createdOn.month)} ${createdOn.day}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: matteBlack,
                                      title: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: appYellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                              text:
                                                  'Are you sure you want to delete list ',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          TextSpan(
                                            text: model.title,
                                            style: const TextStyle(
                                              color: appYellow,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' ?',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.read<ProblemListBloc>().add(
                                                  DeleteProblemList(
                                                      id: model.id),
                                                );
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
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: appYellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: appYellow,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EditListDialogueView(
                                    model: model,
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: appYellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: appYellow,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: BlocConsumer<QuestionListBloc, QuestionListState>(
                  builder: (context, state) {
                    if (state is QuestionListLoadedState) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.questions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: matteBlack,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.questions[index].quesiton.title,
                                          style: const TextStyle(
                                            color: appYellow,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.questions[index].quesiton
                                                  .difficulty,
                                              style: TextStyle(
                                                color: getColor(
                                                  state.questions[index]
                                                      .quesiton.difficulty,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${state.questions[index].quesiton.acRate.toString()}%',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit_document,
                                        color: appYellow,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: appYellow,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Mark Done',
                                          style: TextStyle(
                                            color: appYellow,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: appYellow,
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Web',
                                          style: TextStyle(
                                            color: appYellow,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: appYellow,
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: appYellow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
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

String getMonthName(int monthNumber) {
  // Define a list of month names
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Validate the input and return the corresponding month's name
  if (monthNumber < 1 || monthNumber > 12) {
    return 'Invalid month number';
  } else {
    return monthNames[monthNumber - 1];
  }
}
