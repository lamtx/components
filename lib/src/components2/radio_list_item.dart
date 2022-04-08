import 'package:flutter/material.dart';

import '../../components.dart';
import '../../dimens.dart';

class RadioListItem<T> extends StatelessWidget {
  const RadioListItem({
    Key? key,
    required this.value,
    this.groupValue,
    required this.onChanged,
    required this.title,
    this.contentPadding = activityHorizontalMargin,
    this.toggleable = false,
  })  : _isDense = false,
        super(key: key);

  const RadioListItem.dense({
    Key? key,
    required this.value,
    this.groupValue,
    required this.onChanged,
    required this.title,
    this.contentPadding = EdgeInsets.zero,
    this.toggleable = false,
  })  : _isDense = true,
        super(key: key);

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget title;
  final EdgeInsets contentPadding;
  final bool _isDense;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: _isDense ? 0 : listPreferredItemHeightSmall,
        ),
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
      ),
    );
  }
}
