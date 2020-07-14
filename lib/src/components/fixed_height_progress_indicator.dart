import 'package:flutter/material.dart';

class FixedHeightProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const FixedHeightProgressIndicator({Key key, @required this.isLoading})
      : assert(isLoading != null),
        super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      child: isLoading ? const LinearProgressIndicator() : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(1);
}
