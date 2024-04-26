import 'package:flutter/material.dart';

class CodeSnippetView extends StatelessWidget {
  final String url;
  const CodeSnippetView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width - 16,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.fill),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
