import 'dart:async';

import 'package:flutter/material.dart';

enum ToastLength { short, long }

typedef PositionedToastBuilder = Widget Function(
    BuildContext context, Widget child);

class Toast {
  factory Toast() {
    return _instance ??= Toast._();
  }

  Toast._();

  static const short = Duration(seconds: 2);
  static const long = Duration(seconds: 6);

  static Toast? _instance;
  OverlayEntry? _entry;
  Timer? _timer;

  void _showOverlay(
    OverlayState overlay,
    OverlayEntry entry,
    Duration duration,
  ) {
    _timer?.cancel();
    _entry?.remove();
    _entry = entry;
    overlay.insert(entry);
    _timer = Timer(duration + const Duration(milliseconds: 360), () {
      entry.remove();
      _entry = null;
    });
  }

  void showToast({
    required BuildContext context,
    required Widget child,
    PositionedToastBuilder positionedToastBuilder = _bottomPositionedBuilder,
    Duration duration = short,
  }) {
    showToastByOverlay(
      overlay: Overlay.of(context)!,
      child: child,
      positionedBuilder: positionedToastBuilder,
      duration: duration,
    );
  }

  void showToastByOverlay({
    required OverlayState overlay,
    required Widget child,
    PositionedToastBuilder positionedBuilder = _bottomPositionedBuilder,
    Duration duration = short,
  }) {
    final newChild = _ToastWidget(
      child,
      duration,
    );
    final entry = OverlayEntry(
      builder: (context) => positionedBuilder(context, newChild),
    );
    _showOverlay(overlay, entry, duration);
  }
}

Positioned _bottomPositionedBuilder(BuildContext context, Widget child) {
  return Positioned(bottom: 50, left: 24, right: 24, child: child);
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget(this.child, this.duration, {Key? key}) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _timer = Timer(widget.duration, () {
      _animationController.reverse();
    });
    _animationController.forward();
  }

  @override
  void deactivate() {
    _timer.cancel();
    _animationController.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
