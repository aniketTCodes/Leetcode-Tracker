import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';

class CodeSnippetView extends StatelessWidget {
  final String url;
  const CodeSnippetView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, image) => Container(
        height: MediaQuery.of(context).size.width - 16,
        decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.fill),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: double.infinity,
      ),
      placeholder: (context, url) => const Center(
        child: Text(
          'Loading...',
          style: TextStyle(
            color: appYellow,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
