import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'template_messages.dart';

final class EmptyInfo extends StatelessWidget {
  const EmptyInfo({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: itemSpacingTop + spacingHorizontal,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
            child: child ?? Text(TemplateMessages.of(context).noItems),
          ),
        ),
      ),
    );
  }
}
