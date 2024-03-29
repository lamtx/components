import 'package:flutter/material.dart';

final class NoColorizedImageIcon extends StatelessWidget {
  const NoColorizedImageIcon(
    this.image, {
    super.key,
    this.size,
  });

  final double? size;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final iconSize = size ?? theme.size ?? 24;
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: Image(image: image),
      ),
    );
  }
}
