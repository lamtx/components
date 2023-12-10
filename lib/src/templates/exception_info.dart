import 'package:flutter/material.dart';

import '../../dimens.dart';
import 'get_exception_message.dart';

final class ExceptionInfo extends StatelessWidget {
  const ExceptionInfo(this.exception, {super.key});

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemSpacingTop + spacingHorizontal,
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
