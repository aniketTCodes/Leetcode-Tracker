import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'package:leetcode_tracker/features/tags/view/tag_alert_view.dart';

class SolutionAddEditView extends StatefulWidget {
  final Question question;
  final SolutionModel? solution;

  const SolutionAddEditView({super.key, required this.question, this.solution});

  @override
  State<SolutionAddEditView> createState() => _AddEditSolutionState();
}

class _AddEditSolutionState extends State<SolutionAddEditView> {
  late TextEditingController _goalController;
  late TextEditingController _optimizationController;
  late TextEditingController _rationaleController;
  late List<TagModel> tags = widget.solution?.tags ?? [];
  @override
  void initState() {
    _goalController =
        TextEditingController(text: widget.solution?.problemGoal ?? '');
    _optimizationController =
        TextEditingController(text: widget.solution?.optimization ?? '');
    _rationaleController =
        TextEditingController(text: widget.solution?.rationale ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: matteBlack,
        surfaceTintColor: matteBlack,
        title: Text(
          widget.question.title,
          style: const TextStyle(
            color: appYellow,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.navigate_before,
            color: appYellow,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: matteBlack,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        color: matteBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tags',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Wrap(
                        spacing: 8,
                        children: <Widget>[
                              Chip(
                                deleteIcon: const Icon(
                                  Icons.add_circle,
                                  color: matteBlack,
                                ),
                                label: const Text(
                                  'Add Tags',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: accentBlack,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                onDeleted: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          backgroundColor: matteBlack,
                                          title: const Text(
                                            'Add Tag',
                                            style: TextStyle(
                                                color: appYellow, fontSize: 18),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  tags =
                                                      widget.solution?.tags ??
                                                          tags;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Done',
                                                style: TextStyle(
                                                  color: appYellow,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                          content: TagAlertDialogueView(
                                            solutionTags: tags,
                                          ));
                                    },
                                  );
                                },
                              )
                            ] +
                            tags
                                .map(
                                  (e) => Chip(
                                    deleteIcon: const Icon(
                                      Icons.close_rounded,
                                      color: matteBlack,
                                    ),
                                    backgroundColor: accentBlack,
                                    label: Text(
                                      e.name,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(e.a, e.r, e.g, e.b),
                                      ),
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        tags.remove(e);
                                      });
                                    },
                                  ),
                                )
                                .toList()),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Problem Goal',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      controller: _goalController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              15,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: appYellow,
                          ),
                        ),
                        hintText: 'Describle the goal of problem',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 143, 125, 125),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: appYellow,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Optimization',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      controller: _optimizationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              15,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: appYellow,
                          ),
                        ),
                        hintText:
                            'Write the about your initial approach and how you optimized it',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 143, 125, 125),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: appYellow,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Rationale',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      controller: _rationaleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              15,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: appYellow,
                          ),
                        ),
                        hintText: 'Describle your approach',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 143, 125, 125),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: appYellow,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 16,
                      child: FloatingActionButton(
                        backgroundColor: appYellow,
                        onPressed: () {
                          context.read<SolutionBloc>().add(SaveSolutionEvent(
                              question: widget.question,
                              problemGoal: _goalController.text,
                              optimization: _optimizationController.text,
                              rationale: _rationaleController.text,
                              tags: tags));
                        },
                        child: const Text('Done'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
