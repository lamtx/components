import 'package:flutter/material.dart';

import '../../components2.dart';
import '../../dimens.dart';
import 'platform/platform_expand_icon.dart';

typedef AnimationBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child);

final class Expander extends StatefulWidget {
  @Deprecated("Use the material 3 version.")
  const Expander({
    required this.onTitlePressed,
    required this.title,
    required this.child,
    this.expanded = false,
    this.showExpanderIcon = false,
    this.onTitleLongPressed,
    this.animationDuration = shortAnimationDuration,
    this.animationBuilder,
    super.key,
  });

  final Widget title;
  final Widget child;
  final bool expanded;
  final bool showExpanderIcon;
  final Duration animationDuration;
  final void Function(bool expanded) onTitlePressed;
  final VoidCallback? onTitleLongPressed;
  final AnimationBuilder? animationBuilder;

  @override
  State<StatefulWidget> createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _controller.value = widget.expanded ? 1 : 0;
  }

  @override
  void didUpdateWidget(Expander oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != widget.expanded) {
      _expand(widget.expanded);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.showExpanderIcon
        ? Row(
            children: <Widget>[
              Expanded(
                child: widget.title,
              ),
              PlatformExpandIcon(
                isExpanded: widget.expanded,
              )
            ],
          )
        : widget.title;
    final child = widget.animationBuilder == null
        ? FadeSlideTransition(
            sizeFactor: _controller,
            child: widget.child,
          )
        : widget.animationBuilder!(context, _controller, widget.child);
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => widget.onTitlePressed(!widget.expanded),
          onLongPress: widget.onTitleLongPressed,
          child: title,
        ),
        child,
      ],
    );
  }

  void _expand(bool expanded) {
    if (expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
