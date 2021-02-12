import 'package:flutter/material.dart';

class NoColorizedImageIcon extends StatelessWidget {
  const NoColorizedImageIcon(
    this.image, {
    Key? key,
    this.size,
  }) : super(key: key);

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
