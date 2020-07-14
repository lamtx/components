import 'package:flutter/material.dart';

import '../../dimens.dart';
import '../../ext.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    this.children,
    this.avoidBottom = true,
  }) : super(key: key);

  final List<Widget> children;
  final bool avoidBottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: avoidBottom,
      minimum: activityHorizontalMargin + activityMarginBottom + itemSpacingTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children
            .withIndex()
            .map((e) => e.index == 0
                ? e.value
                : Padding(
                    padding: itemSpacingStart,
                    child: e.value,
                  ))
            .toList(),
      ),
    );
  }
}
