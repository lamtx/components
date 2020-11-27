import 'package:flutter/material.dart';

import 'exception_info.dart';
import 'loading_info.dart';

class Loadable extends StatelessWidget {
  const Loadable({
    Key? key,
    this.exception,
    required this.isLoading,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;
  final Exception? exception;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingInfo()
        : exception != null
            ? ExceptionInfo(exception!)
            : builder(context);
  }
}
