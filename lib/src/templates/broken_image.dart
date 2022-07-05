import 'package:flutter/material.dart';

class BrokenImage extends StatelessWidget {
  const BrokenImage({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    double size;
    if (width == null || height == null) {
      size = 96;
    } else if (width!.isInfinite) {
      size = height! / 2;
    } else if (height!.isInfinite) {
      size = width! / 2;
    } else {
      size = (width! + height!) / 4;
    }
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).canvasColor,
      child: Icon(
        Icons.image,
        size: size,
        color: const Color(0xffDBE0E4),
      ),
    );
  }
}
