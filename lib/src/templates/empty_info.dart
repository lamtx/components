import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'template_messages.dart';

class EmptyInfo extends StatelessWidget {
  const EmptyInfo({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: activityMargin + itemSpacingTop,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
            child: child ?? Text(TemplateMessages.of(context).noItems),
          ),
        ),
      ),
    );
  }
}
