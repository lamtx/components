import 'package:flutter/material.dart';

final class FixedHeightProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const FixedHeightProgressIndicator({
    required this.isLoading,
    this.value,
    this.height = 1,
    super.key,
  });

  final bool isLoading;
  final double? value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isLoading ? LinearProgressIndicator(value: value) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
