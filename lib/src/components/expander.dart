import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'fade_slide_transition.dart';
import 'platform.dart';

class Expander extends StatefulWidget {
  const Expander({
    @required this.onTitlePressed,
    Key key,
    this.title,
    this.child,
    this.expanded = false,
    this.showExpanderIcon = false,
    this.onTitleLongPressed,
  })  : assert(onTitlePressed != null),
        super(key: key);

  final Widget title;
  final Widget child;
  final bool expanded;
  final bool showExpanderIcon;
  final void Function(bool expanded) onTitlePressed;
  final VoidCallback onTitleLongPressed;

  @override
  State<StatefulWidget> createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: shortAnimationDuration,
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
    return Column(
      children: <Widget>[
        PlatformInkWell(
          onTap: () => widget.onTitlePressed(widget.expanded),
          onLongPress: widget.onTitleLongPressed,
          child: title,
        ),
        FadeSlideTransition(
          sizeFactor: _controller,
          child: widget.child,
        ),
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
