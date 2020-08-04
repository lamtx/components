import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRadio<T> extends StatefulWidget {
  const CupertinoRadio({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  }) : super(key: key);

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  _CupertinoRadioState<T> createState() => _CupertinoRadioState<T>();
}

class _CupertinoRadioState<T> extends State<CupertinoRadio<T>>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      value: widget.value == widget.groupValue ? 1 : 0,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(CupertinoRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldValue = oldWidget.groupValue == oldWidget.value;
    final newValue = widget.groupValue == widget.value;
    if (oldValue != newValue) {
      _toggle(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_controller.isDismissed || _controller.isCompleted) {
      child = Icon(widget.value == widget.groupValue
          ? CupertinoIcons.check_mark_circled_solid
          : CupertinoIcons.circle);
    } else {
      child = Stack(
        children: <Widget>[
          Transform.scale(
            scale: _controller.value,
            child: const Icon(CupertinoIcons.check_mark_circled_solid),
          ),
          const Icon(CupertinoIcons.circle),
        ],
      );
    }
    return SizedBox(
      width: 48,
      height: 48,
      child: Center(child: child),
    );
  }

  void _toggle(bool checked) {
    if (checked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
