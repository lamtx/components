import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'platform.dart';

class RadioItem<T> extends StatelessWidget {
  const RadioItem({
    Key key,
    this.value,
    this.groupValue,
    this.onChanged,
    @required this.title,
    this.contentPadding = activityHorizontalMargin,
    this.toggleable = false,
  })  : _isDense = false,
        assert(title != null),
        super(key: key);

  const RadioItem.dense({
    Key key,
    this.value,
    this.groupValue,
    this.onChanged,
    @required this.title,
    this.contentPadding = EdgeInsets.zero,
    this.toggleable = false,
  })  : _isDense = true,
        assert(title != null),
        super(key: key);

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Widget title;
  final EdgeInsets contentPadding;
  final bool _isDense;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    return PlatformInkWell(
      onTap: () {
        if (toggleable) {
          if (value == groupValue) {
            onChanged(null);
          } else {
            onChanged(value);
          }
        } else if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: contentPadding,
        child: Row(
          mainAxisSize: _isDense ? MainAxisSize.min : MainAxisSize.max,
          children: <Widget>[
            PlatformRadio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            if (_isDense) title else Expanded(child: title)
          ],
        ),
      ),
    );
  }
}
