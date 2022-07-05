import 'package:flutter/material.dart';

import '../../dimens.dart';

class LoadingText extends StatelessWidget {
  const LoadingText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: itemSpacing,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              Padding(
                padding: textSpacingStart,
                child: Text(text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
