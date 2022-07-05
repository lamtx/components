import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'misc.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget title;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: listPreferredItemHeightSmall,
        ),
        child: decidePadding(
          padding: contentPadding,
          child: Row(
            children: <Widget>[
              Expanded(child: title),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
