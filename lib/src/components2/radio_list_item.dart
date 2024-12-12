import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'misc.dart';

@Deprecated("Use material 3 RadioListTile.adaptive")
final class RadioListItem<T> extends StatelessWidget {
  @Deprecated("Use material 3 RadioListTile.adaptive")
  const RadioListItem({
    required this.value,
    required this.onChanged,
    required this.title,
    this.groupValue,
    this.contentPadding,
    this.toggleable = false,
    super.key,
  }) : _isDense = false;

  @Deprecated("Use material 3 RadioListTile.adaptive")
  const RadioListItem.dense({
    required this.value,
    required this.onChanged,
    required this.title,
    this.groupValue,
    this.contentPadding = EdgeInsets.zero,
    this.toggleable = false,
    super.key,
  }) : _isDense = true;

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget title;
  final EdgeInsets? contentPadding;
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
        child: decidePadding(
          padding: contentPadding,
          child: Row(
            mainAxisSize: _isDense ? MainAxisSize.min : MainAxisSize.max,
            children: <Widget>[
              Radio<T>(
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
