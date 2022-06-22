import 'package:flutter/material.dart';

typedef PathPainter = void Function(Canvas canvas, Size size, {Color? fill});

class VectorIcon extends StatelessWidget {
  const VectorIcon(
    this.painter, {
    Key? key,
    this.size,
    this.color,
  })  : super(key: key);

  final double? size;
  final Color? color;
  final PathPainter painter;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final iconSize = size ?? theme.size ?? 24;
    final iconColor = color ?? theme.color;
    assert(iconSize != 0);
    assert(iconColor != null && iconColor != Colors.transparent);
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
  _Painter({this.color, required this.painter});

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
