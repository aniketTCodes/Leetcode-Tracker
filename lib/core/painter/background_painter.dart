import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:leetcode_tracker/core/constants/app_colors.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final rect = Path();
    final rectPaint = Paint();
    rectPaint.shader = ui.Gradient.linear(
        Offset(width * 0.5, height * 0.3),
        Offset(width * 0.5, height),
        [appYellow, const Color.fromARGB(255, 247, 203, 149)]);
    rect.addRect(Rect.fromLTRB(0, 0, width, height));
    canvas.drawPath(rect, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
