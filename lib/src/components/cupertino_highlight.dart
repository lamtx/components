import 'package:flutter/material.dart';

class CupertinoHighlight extends StatefulWidget {
  const CupertinoHighlight({
    Key? key,
    this.child,
    this.onTap,
    this.onLongPress,
    this.tooltip,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? tooltip;

  @override
  _CupertinoHighlightState createState() => _CupertinoHighlightState();
}

class _CupertinoHighlightState extends State<CupertinoHighlight>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  Color? _backgroundColor = Colors.transparent;
  bool _buttonHeldDown = false;
  final Tween<Color?> _colorTween = ColorTween(begin: Colors.transparent);
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  static const _darkColor = Color(0x0FFFFFFF);
  static const _lightColor = Color(0x0f000000);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.addListener(() {
      setState(() {
        _backgroundColor = _colorAnimation.value;
      });
    });
    _colorAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_colorTween);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      color: _backgroundColor,
      child: widget.child,
    );
    if (widget.tooltip != null) {
      child = Tooltip(
        message: widget.tooltip!,
        child: child,
      );
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    _colorTween.end = isDark ? _darkColor : _lightColor;
    if (widget.onTap == null && widget.onLongPress == null) {
      return child;
    }
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: child,
    );
  }

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final wasHeldDown = _buttonHeldDown;
    final ticker = _buttonHeldDown
        ? _animationController.animateTo(1, duration: kFadeOutDuration)
        : _animationController.animateTo(0, duration: kFadeInDuration);
    ticker.then<void>((value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
