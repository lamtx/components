import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ToastLength { short, long }

typedef PositionedToastBuilder = Widget Function(
    BuildContext context, Widget child);

class Toast {
  factory Toast() {
    return _instance ??= Toast._();
  }

  Toast._();

  static Toast? _instance;
  final _queue = Queue<_ToastEntry>();
  Timer? _timer;

  void _showOverlay(OverlayState overlay) {
    if (_queue.isEmpty) {
      return;
    }
    final entry = _queue.removeFirst();
    overlay.insert(entry.entry);
    _timer = Timer(entry.duration + const Duration(milliseconds: 360), () {
      _showNextEntry(overlay, entry.entry);
    });
  }

  void _showNextEntry(OverlayState overlay, OverlayEntry entry) {
    entry.remove();
    _timer = null;
    _showOverlay(overlay);
  }

  void showToast({
    required BuildContext context,
    required Widget child,
    PositionedToastBuilder? positionedToastBuilder,
    Duration toastDuration = const Duration(seconds: 2),
  }) {
    final newChild = _ToastStateFul(
      child,
      toastDuration,
    );
    final newEntry = OverlayEntry(
      builder: (context) => positionedToastBuilder != null
          ? positionedToastBuilder(context, newChild)
          : _getPositionWidgetBasedOnGravity(newChild),
    );
    _queue.add(_ToastEntry(
      entry: newEntry,
      duration: toastDuration,
    ));
    if (_timer == null) {
      _showOverlay(Overlay.of(context)!);
    }
  }

  Positioned _getPositionWidgetBasedOnGravity(Widget child) {
    return Positioned(bottom: 50, left: 24, right: 24, child: child);
  }
}

class _ToastEntry {
  const _ToastEntry({required this.entry, required this.duration});

  final OverlayEntry entry;
  final Duration duration;
}

class _ToastStateFul extends StatefulWidget {
  const _ToastStateFul(this.child, this.duration, {Key? key}) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

class ToastStateFulState extends State<_ToastStateFul>
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
