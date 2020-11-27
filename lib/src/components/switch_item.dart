import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'platform.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding = activityHorizontalMargin,
  })  : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget title;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return PlatformInkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: listPreferredItemHeightSmall,
        padding: contentPadding,
        child: Row(
          children: <Widget>[
            Expanded(child: title),
            PlatformSwitch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
