import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueToActionListener<T extends Object> extends StatefulWidget {
  const ValueToActionListener({
    required this.listenable,
    required this.actionBuilder,
    super.key,
    this.child = const SizedBox.shrink(),
  });

  final ValueListenable<T?> listenable;
  final void Function(BuildContext context, T value) actionBuilder;
  final Widget child;

  @override
  State<ValueToActionListener<T>> createState() => _ValueToActionState();
}

class _ValueToActionState<T extends Object>
    extends State<ValueToActionListener<T>> {
  var _actionCalled = false;

  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_onValueChanged);
    _onValueChanged();
  }

  @override
  void didUpdateWidget(covariant ValueToActionListener<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.listenable, oldWidget.listenable)) {
      oldWidget.listenable.removeListener(_onValueChanged);
      widget.listenable.addListener(_onValueChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.listenable.removeListener(_onValueChanged);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _performAction(T value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.actionBuilder(context, value);
    });
  }

  void _onValueChanged() {
    final value = widget.listenable.value;
    final shouldShow = value != null;
    if (shouldShow && !_actionCalled) {
      _performAction(value);
    }
    _actionCalled = shouldShow;
  }
}
