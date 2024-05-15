import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';

class NewListAlertDialogueView extends StatefulWidget {
  const NewListAlertDialogueView({super.key});

  @override
  State<NewListAlertDialogueView> createState() =>
      _NewListAlertDialogueViewState();
}

class _NewListAlertDialogueViewState extends State<NewListAlertDialogueView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            context.read<ProblemListBloc>().add(CreateNewProblemListEvent(
                title: titleController.text,
                description: descriptionController.text));
            Navigator.of(context).pop();
          },
          child: const Text(
            'Create',
            style: TextStyle(
              color: appYellow,
              fontSize: 18,
            ),
          ),
        ),
      ],
      backgroundColor: matteBlack,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Create new list',
        style: TextStyle(
          color: appYellow,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Title',
            style: TextStyle(
              color: appYellow,
              fontSize: 16,
            ),
          ),
          TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: titleController,
            cursorColor: appYellow,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appYellow,
                ),
              ),
              isDense: true,
              hintText: 'New list name',
              hintStyle: TextStyle(
                color: accentBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Description',
            style: TextStyle(
              color: appYellow,
              fontSize: 16,
            ),
          ),
          TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: descriptionController,
            cursorColor: appYellow,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appYellow,
                ),
              ),
              isDense: true,
              hintText: 'New list description',
              hintStyle: TextStyle(
                color: accentBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
