import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'dart:developer' as dev show log;

class SearchQuestionView extends StatefulWidget {
  final List<Question>? questions;
  final String loadingMessage;
  const SearchQuestionView(
      {super.key, required this.questions, required this.loadingMessage});

  @override
  State<SearchQuestionView> createState() => _SearchQuestionViewState();
}

class _SearchQuestionViewState extends State<SearchQuestionView> {
  final TextEditingController _searchKeywordController =
      TextEditingController();

  @override
  void dispose() {
    _searchKeywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: matteBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.navigate_before,
            color: appYellow,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Select Question',
          style: TextStyle(color: appYellow),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Question',
              style: TextStyle(color: appYellow, fontSize: 18),
            ),
            TextField(
              controller: _searchKeywordController,
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
                hintText: 'e.g. - 3Sum',
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
              height: 5,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 16,
                child: FloatingActionButton(
                  backgroundColor: appYellow,
                  onPressed: () {
                    if (widget.questions != null) {
                      context.read<SolutionBloc>().add(SearchQuestionEvent(
                          searchKeyword: _searchKeywordController.text));
                    }
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Problems',
              style: TextStyle(
                color: appYellow,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (widget.questions != null) {
                    return ListView.builder(
                      itemCount: widget.questions!.length,
                      itemBuilder: (context, index) {
                        final quesiton = widget.questions![index];
                        return GestureDetector(
                          onTap: () {
                            context.read<SolutionBloc>().add(
                                OnQuesitonSelectEvent(
                                    question: widget.questions![index]));
                          },
                          child: Card(
                            color: const Color.fromARGB(255, 81, 73, 68),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    "${quesiton.frontendQuestionId}. ${quesiton.title}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        quesiton.difficulty,
                                        style: TextStyle(
                                            color:
                                                getColor(quesiton.difficulty),
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        quesiton.acRate.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: appYellow,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                          color: appYellow,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.loadingMessage,
                          style: const TextStyle(
                            color: appYellow,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color getColor(String difficulty) {
  if (difficulty == 'Easy') {
    return Colors.green;
  } else if (difficulty == 'Medium') {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}
