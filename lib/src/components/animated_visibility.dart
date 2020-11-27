import 'package:flutter/cupertino.dart';

import '../../dimens.dart';
import 'fade_slide_transition.dart';

class AnimatedVisibility extends StatefulWidget {
  const AnimatedVisibility({
    required this.visible,
    required this.child,
  });

  final bool visible;
  final Widget child;

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
      duration: shortAnimationDuration,
      value: widget.visible ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(AnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      _animate(widget.visible);
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
    return FadeSlideTransition(
      sizeFactor: _opacityAnimation,
      child: widget.child,
    );
  }
}
