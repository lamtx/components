import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'misc.dart';
import 'platform/platform_icon_button.dart';

class ClearInputButton extends StatefulWidget {
  const ClearInputButton({
    Key? key,
    required this.controller,
    this.icon,
    this.emptyIcon = const SizedBox.shrink(),
  }) : super(key: key);

  final TextEditingController controller;
  final Widget? icon;
  final Widget emptyIcon;

  @override
  _ClearInputButtonState createState() => _ClearInputButtonState();
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
    if (_inputNotEmpty) {
      return widget.icon ?? PlatformIconButton(
        minimumSize: isCupertino ? 32 : 48,
        icon: isCupertino
            ? const Icon(CupertinoIcons.clear_circled_solid)
            : const Icon(Icons.clear),
        onPressed: () => widget.controller.clear(),
      );
    } else {
      return widget.emptyIcon;
    }
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
