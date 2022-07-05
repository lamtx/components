import 'package:flutter/material.dart';

class FixedHeightProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const FixedHeightProgressIndicator({
    required this.isLoading,
    super.key,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: isLoading ? const LinearProgressIndicator() : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(1);
}
