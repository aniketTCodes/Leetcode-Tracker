import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/revist_solutions/view/revisit_solution_view.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'package:leetcode_tracker/features/solutions/view/search_question_view.dart';

class RevisitSolutionHomeView extends StatefulWidget {
  final List<SolutionModel> solutions;
  const RevisitSolutionHomeView({super.key, required this.solutions});

  @override
  State<RevisitSolutionHomeView> createState() =>
      _RevisitSolutionHomeViewState();
}

class _RevisitSolutionHomeViewState extends State<RevisitSolutionHomeView> {
  final TextEditingController searchKeywordController = TextEditingController();
  List<SolutionModel> solutions = [];
  @override
  void initState() {
    solutions = widget.solutions;
    super.initState();
  }

  @override
  void dispose() {
    searchKeywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    solutions = widget.solutions
                        .where((element) => element.questionTitle
                            .toLowerCase()
                            .contains(
                                searchKeywordController.text.toLowerCase()))
                        .toList();
                  });
                },
                controller: searchKeywordController,
                cursorColor: matteBlack,
                decoration: const InputDecoration(
                  focusColor: matteBlack,
                  labelStyle: TextStyle(color: matteBlack),
                  labelText: 'Search Solutions',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: accentBlack,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: solutions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RevisitSolutionview.route,
                      arguments: solutions[index]);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: accentBlack,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}. ${solutions[index].questionTitle}",
                          style: const TextStyle(
                              color: appYellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NotoSerif'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          solutions[index].difficulty,
                          style: TextStyle(
                              color: getColor(solutions[index].difficulty)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
