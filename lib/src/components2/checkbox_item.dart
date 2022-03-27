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
    this.mainAxisSize = MainAxisSize.max,
    this.isLoading = false,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget title;
  final EdgeInsets contentPadding;
  final MainAxisSize mainAxisSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null || isLoading ? null : () => onChanged!(!value),
      child: Padding(
        padding: contentPadding,
        child: Row(
          mainAxisSize: mainAxisSize,
          children: <Widget>[
            if (isLoading)
              SizedBox(
                width: 32,
                height: 32,
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
}
