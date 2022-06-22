import 'package:flutter/cupertino.dart';

import '../../dimens.dart';
import 'expander.dart';
import 'fade_slide_transition.dart';

class AnimatedVisibility extends StatefulWidget {
  const AnimatedVisibility({
    required this.visible,
    required this.child,
    this.duration = shortAnimationDuration,
    this.animationBuilder,
  });

  final bool visible;
  final Widget child;
  final Duration duration;
  final AnimationBuilder? animationBuilder;

  @override
  State<StatefulWidget> createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility>
    with TickerProviderStateMixin {
  late AnimationController _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityAnimation = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.visible ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(AnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      _animate(widget.visible);
    }
    if (widget.duration != oldWidget.duration) {
      throw StateError("Duration of `AnimatedVisibility` cannot be changed.");
    }
  }

  void _animate(bool visible) {
    if (visible) {
      _opacityAnimation.forward();
    } else {
      _opacityAnimation.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationBuilder
            ?.call(context, _opacityAnimation, widget.child) ??
        FadeSlideTransition(
          sizeFactor: _opacityAnimation,
          child: widget.child,
        );
  }
}
