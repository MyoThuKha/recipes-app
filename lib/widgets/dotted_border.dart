import 'package:flutter/material.dart';

class BottomDashedLine extends CustomPainter {
  final Color color;
  final double dashWidth, dashHeight, dashGap;

  BottomDashedLine({super.repaint, this.color = Colors.grey, this.dashWidth = 10, this.dashHeight = 2, this.dashGap = 1.2});
  @override
  void paint(Canvas canvas, Size size) {
    double start = 0;
    double startHeight = size.height;
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashHeight;

    while (start < size.width) {
      final x = start * dashGap;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromPoints(
              Offset(x, startHeight),
              Offset(dashWidth + x, dashHeight + startHeight),
            ),
            const Radius.circular(100)),
        paint,
      );

      start += (dashWidth + dashGap);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
