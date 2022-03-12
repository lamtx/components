import 'package:flutter/material.dart';

import '../../dimens.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding = activityHorizontalMargin,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget title;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: listPreferredItemHeightSmall,
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
    );
  }
}
