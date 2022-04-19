import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import 'misc.dart';

class CheckboxItem extends StatelessWidget {
  const CheckboxItem({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding,
    this.mainAxisSize = MainAxisSize.max,
    this.isLoading = false,
  }) : super(key: key);

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
                child: Center(child: PlatformActivityIndicator()),
              )
            else
              PlatformCheckbox(
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
      default:
        return 32;
    }
  }
}
