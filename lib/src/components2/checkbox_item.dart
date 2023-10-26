import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'misc.dart';

final class CheckboxItem extends StatelessWidget {
  const CheckboxItem({
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding,
    this.mainAxisSize = MainAxisSize.max,
    this.isLoading = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget title;
  final EdgeInsets? contentPadding;
  final MainAxisSize mainAxisSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = _getCheckBoxSize();
    return InkWell(
      onTap: onChanged == null || isLoading ? null : () => onChanged!(!value),
      child: decidePadding(
        padding: contentPadding,
        child: Row(
          mainAxisSize: mainAxisSize,
          children: <Widget>[
            if (isLoading)
              SizedBox(
                width: size,
                height: size,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            else
              Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            Flexible(child: title)
          ],
        ),
      ),
    );
  }

  static double _getCheckBoxSize() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return 48;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return 32;
    }
  }
}
