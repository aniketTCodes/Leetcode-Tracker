import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';

class SolutionView extends StatefulWidget {
  static const route = '/solution';
  const SolutionView({super.key});

  @override
  State<SolutionView> createState() => _AddEditSolutionState();
}

class _AddEditSolutionState extends State<SolutionView> {
  late TextEditingController _intuitionController;
  late TextEditingController _aproachController;
  late TextEditingController _complexityController;
  @override
  void initState() {
    _intuitionController = TextEditingController();
    _aproachController = TextEditingController();
    _complexityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: matteBlack,
        surfaceTintColor: matteBlack,
        title: const Text(
          'Add solution',
          style: TextStyle(
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
            const Text(
              'Question',
              style: TextStyle(
                color: appYellow,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            DropdownMenu(
              width: MediaQuery.of(context).size.width - 16,
              dropdownMenuEntries: const [],
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Intuition',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      controller: _intuitionController,
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
                            'Ideas or patterns that helped you figuring out the approach',
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
                      'Approach',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      controller: _aproachController,
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
                        hintText: 'Pesudo code, Algorithm, Optimizations',
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
                      'Complexity',
                      style: TextStyle(
                        color: appYellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      controller: _complexityController,
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
                        hintText: 'Complexity of your approach',
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
                        onPressed: () {},
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
