import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  final int borderRadius;
  final Color color;
  final bool isSelected;
  final Function() onSelect;
  const ColorIndicator(
      {super.key,
      required this.borderRadius,
      required this.color,
      required this.isSelected,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(
                borderRadius * 1.0,
              ),
            ),
          ),
          child: isSelected ? const Icon(Icons.check) : null),
    );
  }
}
