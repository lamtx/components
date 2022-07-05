import "dart:math" as math;

import "package:flutter/material.dart";

class FadeSizeTransition extends AnimatedWidget {
  const FadeSizeTransition({
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
    AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1);
    }
    return Opacity(
      opacity: sizeFactor.value,
      child: Align(
        alignment: alignment,
        heightFactor: axis == Axis.vertical ? math.max(sizeFactor.value, 0) : 1,
        widthFactor:
            axis == Axis.horizontal ? math.max(sizeFactor.value, 0) : 1,
        child: child,
      ),
    );
  }
}
