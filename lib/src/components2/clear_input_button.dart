import 'package:flutter/material.dart';

class ClearInputButton extends StatefulWidget {
  const ClearInputButton({
    required this.controller,
    this.icon,
    this.emptyIcon = const SizedBox.shrink(),
    super.key,
  });

  final TextEditingController controller;
  final Widget? icon;
  final Widget emptyIcon;

  @override
  State<ClearInputButton> createState() => _ClearInputButtonState();
}

class _ClearInputButtonState extends State<ClearInputButton> {
  var _inputNotEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
    _inputNotEmpty = widget.controller.text.isNotEmpty;
  }

  @override
  void didUpdateWidget(covariant ClearInputButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {
      oldWidget.controller.removeListener(_onChanged);
      widget.controller.addListener(_onChanged);
      _inputNotEmpty = widget.controller.text.isNotEmpty;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_onChanged);
  }

  @override
  Widget build(BuildContext context) {
    return _inputNotEmpty
        ? widget.icon ??
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => widget.controller.clear(),
            )
        : widget.emptyIcon;
  }

  void _onChanged() {
    final isNotEmpty = widget.controller.text.isNotEmpty;
    if (isNotEmpty != _inputNotEmpty) {
      setState(() {
        _inputNotEmpty = isNotEmpty;
      });
    }
  }
}
