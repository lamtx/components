import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../cupertino_highlight.dart';

class PlatformIconButton extends StatelessWidget {
  const PlatformIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24,
    this.color,
    this.tooltip,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoHighlight(
        onTap: onPressed,
        tooltip: tooltip,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: iconSize,
              width: iconSize,
              child: Center(
                child: IconTheme.merge(
                  data: IconThemeData(
                    size: iconSize,
                    color: color
                  ),
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return IconButton(
        icon: icon,
        onPressed: onPressed,
        iconSize: iconSize,
        color: color,
        tooltip: tooltip,
      );
    }
  }
}
