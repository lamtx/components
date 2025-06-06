import 'package:flutter/material.dart';

typedef PathPainter = void Function(Canvas canvas, Size size, {Color? fill});

final class VectorIcon extends StatelessWidget {
  const VectorIcon(
    this.painter, {
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;
  final PathPainter painter;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final iconSize = size ?? theme.size ?? 24;
    final iconColor = color ?? theme.color;
    assert(iconSize != 0);
    return CustomPaint(
      painter: _Painter(
        color: iconColor,
        painter: painter,
      ),
      size: Size.square(iconSize),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    required this.painter,
    this.color,
  });

  final Color? color;
  final PathPainter painter;

  @override
  void paint(Canvas canvas, Size size) {
    painter(canvas, size, fill: color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;

  @override
  bool operator ==(Object other) {
    return other is _Painter &&
        other.color == color &&
        other.painter == painter;
  }
}
