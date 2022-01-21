import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'get_exception_message.dart';

class ExceptionInfo extends StatelessWidget {
  const ExceptionInfo(this.exception);

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: activityHorizontalMargin + itemSpacingTop,
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          getExceptionMessage(context, exception),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
