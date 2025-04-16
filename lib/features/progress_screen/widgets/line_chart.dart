import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dataPoints = [0.4, 0.7, 0.8, 0.6, 0.9];
    final padding = 30.0;
    final availableWidth = size.width - padding * 2;
    final labelHeight = 16.0;
    final chartHeight = size.height - labelHeight;

    // Line paint
    final paint =
        Paint()
          ..color = const Color(0xff717FFE)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;

    // Area paint
    final areaPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff9DA6FE),
              const Color(0xffDADEFF).withAlpha(40),
            ],
          ).createShader(
            Rect.fromLTRB(padding, 50, size.width - padding, chartHeight),
          );

    // Create list of points
    final points = List<Offset>.generate(dataPoints.length, (i) {
      final x = padding + availableWidth * (i / (dataPoints.length - 1));
      final y = chartHeight - (chartHeight * dataPoints[i]);
      return Offset(x, y);
    });

    // Create curved path
    final path = Path();
    final areaPath = Path();

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      areaPath.moveTo(points.first.dx, chartHeight);
      areaPath.lineTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        final p0 = points[i - 1];
        final p1 = points[i];

        // Calculate control points for smooth curve
        final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

        path.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );

        areaPath.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );
      }

      areaPath.lineTo(points.last.dx, chartHeight);
      areaPath.close();
    }

    // Draw area first
    canvas.drawPath(areaPath, areaPaint);
    // Then draw the curved line on top
    canvas.drawPath(path, paint);

    // Draw grid lines
    final gridPaint =
        Paint()
          ..color = Colors.grey.withValues(alpha:  0.3)
          ..strokeWidth = 0.5;

    // Horizontal grid lines (with side padding)
    for (double y = 0.25; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      canvas.drawLine(
        Offset(padding, yPos),
        Offset(size.width - padding, yPos),
        gridPaint,
      );
    }

    // Draw Y-axis labels
    const textStyle = TextStyle(color: Colors.black54, fontSize: 10);
    for (double y = 0.25; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      final textSpan = TextSpan(
        text: '${(y * 100).toInt()}%',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(2, yPos - textPainter.height / 2));
    }

    // Draw X-axis labels with padding
    const weekLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    for (int i = 0; i < weekLabels.length; i++) {
      final x = padding + availableWidth * (i / (weekLabels.length - 1));
      final textSpan = TextSpan(text: weekLabels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - textPainter.height),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
