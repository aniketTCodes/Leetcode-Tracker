import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/solutions/data/models/problem_set_model.dart';

class SearchQuestionView extends StatefulWidget {
  final List<Question> questions;
  const SearchQuestionView({super.key, required this.questions});

  @override
  State<SearchQuestionView> createState() => _SearchQuestionViewState();
}

class _SearchQuestionViewState extends State<SearchQuestionView> {
  final TextEditingController _searchKeywordController =
      TextEditingController();
  List<Question> questions = [];

  @override
  void initState() {
    questions.addAll(widget.questions);
    super.initState();
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
              keyboardType: TextInputType.multiline,
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
                hintText: 'e.g. - Two Sum',
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
              'Recent AC Solutions',
              style: TextStyle(
                color: appYellow,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  final quesiton = widget.questions[index];
                  return Card(
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
                                    color: getColor(quesiton.difficulty),
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
