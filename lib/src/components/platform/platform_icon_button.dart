import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlatformIconButton extends StatelessWidget {
  const PlatformIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24,
    this.color,
    this.backgroundColor,
    this.tooltip,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.square(48)),
        shape: MaterialStateProperty.all(const CircleBorder()),
        backgroundColor: backgroundColor == null
            ? null
            : MaterialStateProperty.all(backgroundColor!),
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
