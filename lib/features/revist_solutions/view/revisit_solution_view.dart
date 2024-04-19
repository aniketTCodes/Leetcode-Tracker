import 'package:flutter/material.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';

class RevisitSolutionview extends StatelessWidget {
  static const route = '/revisitSolution';
  const RevisitSolutionview({super.key});

  @override
  Widget build(BuildContext context) {
    final SolutionModel solution =
        ModalRoute.of(context)!.settings.arguments as SolutionModel;
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
          solution.questionTitle,
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
                children: solution.tags
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
                solution.problemGoal,
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
                solution.optimization,
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
                solution.rationale,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
