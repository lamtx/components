import 'package:flutter/material.dart';

import 'exception_info.dart';
import 'loading_info.dart';
import 'utilities.dart';

class Loadable extends StatelessWidget {
  const Loadable({
    required this.isLoading,
    required this.builder,
    this.exception,
    this.loadingBuilder = defaultLoadingBuilder,
    this.exceptionBuilder = defaultExceptionBuilder,
    super.key,
  });

  final WidgetBuilder builder;
  final Exception? exception;
  final bool isLoading;
  final WidgetBuilder loadingBuilder;
  final Widget Function(BuildContext context, Exception exception)
      exceptionBuilder;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingInfo()
        : exception != null
            ? ExceptionInfo(exception!)
            : builder(context);
  }
}
