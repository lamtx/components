import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'misc.dart';
import 'platform/platform_icon_button.dart';

class ClearInputButton extends StatefulWidget {
  const ClearInputButton({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  _ClearInputButtonState createState() => _ClearInputButtonState();
}

class _ClearInputButtonState extends State<ClearInputButton> {
  var _inputNotEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void didUpdateWidget(covariant ClearInputButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {
      oldWidget.controller.removeListener(_onChanged);
      widget.controller.addListener(_onChanged);
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
      return PlatformIconButton(
        minimumSize: isCupertino ? 32 : 48,
        icon: const Icon(CupertinoIcons.clear_circled_solid),
        onPressed: () => widget.controller.clear(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _onChanged() {
    setState(() {
      _inputNotEmpty = widget.controller.text.isNotEmpty;
    });
  }
}
