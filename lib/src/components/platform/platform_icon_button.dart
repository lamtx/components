import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../cupertino_highlight.dart';
import '../misc.dart';

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
    // TODO: consider not to use cupertino
    if (isCupertino) {
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
                  data: IconThemeData(size: iconSize, color: color),
                  child: icon,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      final button = TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.square(48)),
          shape: MaterialStateProperty.all(const CircleBorder()),
        ),
        child: SizedBox(
          height: iconSize,
          width: iconSize,
          child: Center(
            child: IconTheme.merge(
              data: IconThemeData(
                size: iconSize,
                color: color ?? Theme.of(context).colorScheme.onSurface,
              ),
              child: icon,
            ),
          ),
        ),
      );
      return tooltip == null
          ? button
          : Tooltip(
              message: tooltip!,
              child: button,
            );
    }
  }
}
