import 'dart:math' as math;

import 'package:flutter/material.dart';

class PlatformExpandIcon extends StatefulWidget {
  const PlatformExpandIcon({
    super.key,
    this.isExpanded = false,
    this.size = 24.0,
    this.padding = const EdgeInsets.all(8),
  });

  final bool isExpanded;
  final double size;
  final EdgeInsetsGeometry padding;

  @override
  State<PlatformExpandIcon> createState() => _PlatformExpandIconState();
}

class _PlatformExpandIconState extends State<PlatformExpandIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  static final _iconTurnTween = Tween<double>(begin: 0, end: 0.5)
      .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PlatformExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: RotationTransition(
        turns: _iconTurns,
        child: Icon(Icons.expand_more, size: widget.size),
      ),
    );
  }
}
