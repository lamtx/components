import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class CopyToClipboardIconButton extends StatefulWidget {
  const CopyToClipboardIconButton({
    required this.textToCopy,
    super.key,
    this.size,
  });

  final String Function() textToCopy;
  final double? size;

  @override
  State<CopyToClipboardIconButton> createState() =>
      _CopyToClipboardIconButtonState();
}

class _CopyToClipboardIconButtonState extends State<CopyToClipboardIconButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation.addListener(_onAnimation);
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          _timer?.cancel();
          _timer = Timer(const Duration(seconds: 3), () {
            _controller.reverse();
          });
        case _:
          break;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animation.removeListener(_onAnimation);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opacity = _animation.value;
    return IconButton(
      onPressed: () {
        final text = widget.textToCopy();
        Clipboard.setData(ClipboardData(text: text));
        _controller.forward();
      },
      icon: Stack(
        children: [
          Opacity(
            opacity: opacity > 0.5 ? 0 : (1 - 2 * opacity),
            child: const Icon(Icons.copy),
          ),
          Opacity(
            opacity: opacity < 0.5 ? 0 : (opacity - 0.5) * 2,
            child: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }

  void _onAnimation() {
    setState(() {});
  }
}
