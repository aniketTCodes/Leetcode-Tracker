import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/question_bloc.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';
import 'package:leetcode_tracker/features/solutions/view/search_question_view.dart';

class SelectQuestionDialogueView extends StatefulWidget {
  const SelectQuestionDialogueView({super.key});

  @override
  State<SelectQuestionDialogueView> createState() =>
      _SelectQuestionDialogueViewState();
}

class _SelectQuestionDialogueViewState
    extends State<SelectQuestionDialogueView> {
  final TextEditingController _searchKeywordController =
      TextEditingController();
  final FocusNode searchKeywordFocusNode = FocusNode();
  final List<Question> questions = [];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: matteBlack,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Question',
              style: TextStyle(color: appYellow, fontSize: 18),
            ),
            TextField(
              focusNode: searchKeywordFocusNode,
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
                    setState(() {
                      searchKeywordFocusNode.unfocus();
                    });
                    context.read<QuestionBloc>().add(SearchQuestionEvent(
                        searchKeyword: _searchKeywordController.text));
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: BlocConsumer<QuestionBloc, QuestionState>(
                builder: (context, state) {
                  if (state is QuestionLoadedState) {
                    if (state.quesitons.isEmpty) {
                      return const Center(
                          child: Text(
                        'Search looks empty :/',
                        style: TextStyle(
                          color: appYellow,
                        ),
                      ));
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final question = state.quesitons[index];
                          return GestureDetector(
                            onTap: () {},
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
                                      "${question.frontendQuestionId}. ${question.title}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          question.difficulty,
                                          style: TextStyle(
                                              color:
                                                  getColor(question.difficulty),
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          question.acRate.toStringAsFixed(1),
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
                        itemCount: state.quesitons.length,
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: appYellow,
                    ),
                  );
                },
                listener: (context, state) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
