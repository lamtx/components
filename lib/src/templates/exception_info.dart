import 'package:flutter/material.dart';

import '../../dimens.dart';
import '../components2/breakpoint.dart';
import 'get_exception_message.dart';

class ExceptionInfo extends StatelessWidget {
  const ExceptionInfo(this.exception, {super.key});

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return BreakpointPadding(
      padding: itemSpacingTop,
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
