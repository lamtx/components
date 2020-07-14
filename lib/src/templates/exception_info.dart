import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'get_exception_message.dart';

class ExceptionInfo extends StatelessWidget {
  const ExceptionInfo(this.exception) : assert(exception != null);

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: activityHorizontalMargin,
      child: Center(
        child: Text(
          getExceptionMessage(context, exception),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
