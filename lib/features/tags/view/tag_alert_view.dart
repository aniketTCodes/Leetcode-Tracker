import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/solutions/bloc/bloc/solution_bloc.dart';
import 'package:leetcode_tracker/features/tags/bloc/bloc/tags_bloc.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'package:leetcode_tracker/features/tags/data/repository/tag_repository.dart';
import 'package:leetcode_tracker/features/tags/view/color_indicator.dart';

class TagAlertDialogueView extends StatefulWidget {
  final List<TagModel> solutionTags;
  const TagAlertDialogueView({super.key, required this.solutionTags});

  @override
  State<TagAlertDialogueView> createState() => _TagAlertDialogueViewState();
}

class _TagAlertDialogueViewState extends State<TagAlertDialogueView> {
  Color selectedColor = Colors.white;
  TextEditingController _tagController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TagsBloc(repository: getIt<TagRepository>())..add(LoadUserTagEvent()),
      child: BlocConsumer<TagsBloc, TagsState>(
        builder: (context, state) {
          if (state is TagDoneState) {
            return Container(
              width: 400,
              constraints: const BoxConstraints(minHeight: 100),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _tagController,
                      cursorColor: appYellow,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter Tag Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: appYellow,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: appYellow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(left: 2, right: 2),
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: tagColors[index],
                              ),
                            ),
                            child: ColorIndicator(
                              borderRadius: 50,
                              color: tagColors[index],
                              isSelected: selectedColor == tagColors[index],
                              onSelect: () {
                                setState(() {
                                  selectedColor = tagColors[index];
                                });
                              },
                            ),
                          ),
                        ),
                        itemCount: tagColors.length,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: FloatingActionButton(
                        backgroundColor: appYellow,
                        onPressed: () {
                          context.read<SolutionBloc>().add(AddTagEvent(
                              tag: TagModel(
                                  name: _tagController.text,
                                  a: selectedColor.alpha,
                                  r: selectedColor.red,
                                  g: selectedColor.green,
                                  b: selectedColor.blue)));
                          _tagController.clear();
                        },
                        child: const Text('Add'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Your Tags',
                      style: TextStyle(
                        color: appYellow,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Builder(
                        builder: (context) {
                          return const Text(
                            'No Tags found',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: appYellow,
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
