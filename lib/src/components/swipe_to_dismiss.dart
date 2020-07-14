import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../dimens.dart';
import '../../ext.dart';
import 'fade_slide_transition.dart';

class SwipeToDismiss extends StatefulWidget {
  const SwipeToDismiss({
    Key key,
    @required this.dismissible,
    @required this.child,
    @required this.onDismissed,
  }) : super(key: key);

  final bool dismissible;
  final Widget child;
  final VoidCallback onDismissed;

  @override
  _SwipeToDismissState createState() => _SwipeToDismissState();
}

class _SwipeToDismissState extends State<SwipeToDismiss>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _dismissAnimation;
  Animation<Offset> _animation;
  Offset _dragOffset = Offset.zero;
  double _maxTranslate;
  bool _dismissed = false;
  bool _onDismissedCalled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: shortAnimationDuration,
    );
    _controller.addListener(() {
      setState(() {
        _dragOffset = _animation.value;
      });
    });
    _controller.addStatusListener((status) {
      if (_dismissed && !_onDismissedCalled) {
        _onDismissedCalled = true;
        _dismissAnimation.reverse(from: 1);
      }
    });
    _dismissAnimation = AnimationController(
      vsync: this,
      value: 1,
      duration: shortAnimationDuration,
    );
    _dismissAnimation.addListener(() {
      setState(() {});
    });
    _dismissAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.onDismissed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      sizeFactor: _dismissAnimation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        dragStartBehavior: DragStartBehavior.start,
        onHorizontalDragStart: (_) {
          assert(!_dismissed,
              "Dismssed SwipeToDismiss widget should be removed from tree and do not use");
          final renderBox = context.findRenderObject() as RenderBox;
          _maxTranslate = renderBox.size.width;
          _controller.stop();
        },
        onHorizontalDragUpdate: (detail) {
          final dx = widget.dismissible
              ? (_dragOffset.dx + detail.delta.dx).coerceIn(0, _maxTranslate)
              : (_dragOffset.dx + detail.delta.dx / 2)
                  .coerceIn(0, _maxTranslate / 2);
          setState(() {
            _dragOffset = Offset(dx, 0);
          });
        },
        onHorizontalDragEnd: (detail) {
          _snap(detail.velocity.pixelsPerSecond);
        },
        child: Transform.translate(
          offset: _dragOffset,
          child: widget.child,
        ),
      ),
    );
  }

  void _snap(Offset pixelsPerSecond) {
    if (widget.dismissible) {
      _snapLinear(pixelsPerSecond);
    } else {
      _snapToBegin(pixelsPerSecond);
    }
  }

  void _snapToBegin(Offset pixelsPerSecond) {
    _animation = _controller.drive(
      Tween<Offset>(
        begin: _dragOffset,
        end: Offset.zero,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / _maxTranslate;
    final unitsPerSecond = Offset(unitsPerSecondX, 0);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  void _snapLinear(Offset pixelsPerSecond) {
    final speed = pixelsPerSecond.dx;
    final dismiss =
        speed.abs() > 1500 ? speed > 0 : _dragOffset.dx > _maxTranslate / 2;
    if (dismiss) {
      _dismissed = true;
    }
    _animation = _controller.drive(Tween<Offset>(
      begin: _dragOffset,
      end: dismiss ? Offset(_maxTranslate, 0) : Offset.zero,
    ));
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissAnimation.dispose();
    super.dispose();
  }
}
