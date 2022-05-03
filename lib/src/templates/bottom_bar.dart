import 'package:ext/ext.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';
import '../components2/breakpoint.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.children,
    this.avoidBottom = true,
  }) : super(key: key);

  final List<Widget> children;
  final bool avoidBottom;

  @override
  Widget build(BuildContext context) {
    return BreakpointBuilder(
      builder: (_, breakpoint) => SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: avoidBottom,
        minimum:
            breakpoint.horizontalPadding + itemSpacingBottom + itemSpacingTop,
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
      ),
    );
  }
}
