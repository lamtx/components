import 'package:flutter/material.dart';

import '../../components.dart';
import '../../dimens.dart';

class CheckboxItem extends StatelessWidget {
  const CheckboxItem({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.contentPadding = activityHorizontalMargin,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool?> onChanged;
  final Widget title;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: contentPadding,
        child: Row(
          children: <Widget>[
            PlatformCheckbox(
              value: value,
              onChanged: onChanged,
            ),
            Expanded(child: title)
          ],
        ),
      ),
    );
  }
}
