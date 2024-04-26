import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/codeSnippets/view/code_snippet_view.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';

class RevisitSolutionDoneView extends StatefulWidget {
  final SolutionModel solution;
  final List<String> urls;
  const RevisitSolutionDoneView(
      {super.key, required this.solution, required this.urls});

  @override
  State<RevisitSolutionDoneView> createState() =>
      _RevisitSolutionDoneViewState();
}

class _RevisitSolutionDoneViewState extends State<RevisitSolutionDoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: matteBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.navigate_before,
            color: appYellow,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.solution.questionTitle,
          style: const TextStyle(
            color: appYellow,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: widget.solution.tags
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
                            color: Color.fromARGB(e.a, e.r, e.g, e.b),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Problem Goal',
                style: TextStyle(
                  color: appYellow,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.solution.problemGoal,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Optimization',
                style: TextStyle(
                  color: appYellow,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.solution.optimization,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Rationale',
                style: TextStyle(
                  color: appYellow,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.solution.rationale,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.width - 16,
                child: PageView.builder(
                  itemCount: widget.urls.length,
                  itemBuilder: (context, index) {
                    return CodeSnippetView(
                      url: widget.urls[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
