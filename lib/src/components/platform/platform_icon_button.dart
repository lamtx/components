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
    this.minimumSize = 48,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final double minimumSize;

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.square(minimumSize)),
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
