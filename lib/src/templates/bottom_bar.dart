import 'package:flutter/material.dart';

import '../../dimens.dart';

final class BottomBar extends StatelessWidget {
  const BottomBar({
    required this.children,
    this.avoidBottom = true,
    super.key,
  });

  final List<Widget> children;
  final bool avoidBottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: avoidBottom,
      minimum: spacingHorizontal + itemSpacingBottom + itemSpacingTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children.indexed
            .map((e) => e.$1 == 0
                ? e.$2
                : Padding(
                    padding: itemSpacingStart,
                    child: e.$2,
                  ))
            .toList(),
      ),
    );
  }
}
