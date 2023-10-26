import "dart:math" as math;

import "package:flutter/material.dart";

final class FadeSlideTransition extends AnimatedWidget {
  const FadeSlideTransition({
    required Animation<double> sizeFactor,
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    super.key,
  }) : super(listenable: sizeFactor);

  final Widget child;
  final Axis axis;
  final double axisAlignment;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    if (sizeFactor.isDismissed) {
      return Container();
    }
    if (sizeFactor.isCompleted) {
      return child;
    }
    if (sizeFactor.value >= 0.5) {
      return Opacity(
        opacity: (sizeFactor.value - 0.5) * 2,
        child: child,
      );
    }
    AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1);
    }
    return Opacity(
      opacity: 0,
      child: Align(
        alignment: alignment,
        heightFactor:
            axis == Axis.vertical ? math.max(sizeFactor.value * 2, 0) : 1,
        widthFactor:
            axis == Axis.horizontal ? math.max(sizeFactor.value * 2, 0) : 1,
        child: child,
      ),
    );
  }
}
