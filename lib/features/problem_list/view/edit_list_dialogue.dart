import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/problem_list/bloc/bloc/problem_list_bloc.dart';
import 'package:leetcode_tracker/features/problem_list/data/models/problem_list_model.dart';
import 'package:leetcode_tracker/features/problem_list/view/problem_list_view.dart';

class EditListDialogueView extends StatefulWidget {
  final ProblemListModel model;
  const EditListDialogueView({
    super.key,
    required this.model,
  });

  @override
  State<EditListDialogueView> createState() => _EditListDialogueViewState();
}

class _EditListDialogueViewState extends State<EditListDialogueView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    titleController = TextEditingController(text: widget.model.title);
    descriptionController =
        TextEditingController(text: widget.model.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'EDIT LIST',
        style: TextStyle(
          color: appYellow,
        ),
      ),
      backgroundColor: matteBlack,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            final newModel = ProblemListModel(
              id: widget.model.id,
              title: titleController.text,
              description: descriptionController.text,
              createdOn: widget.model.createdOn,
              solved: widget.model.solved,
              total: widget.model.total,
            );
            context.read<ProblemListBloc>().add(
                  EditProblemListEvent(model: newModel),
                );
            Navigator.of(context).pushReplacementNamed(ProblemListView.route,
                arguments: newModel);
          },
          child: const Text(
            'DONE',
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
            'CANCEL',
            style: TextStyle(
              color: appYellow,
            ),
          ),
        ),
      ],
    );
  }
}
