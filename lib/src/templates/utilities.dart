import 'package:flutter/material.dart';

import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';

typedef ExceptionWidgetBuilder = Widget Function(
    BuildContext context, Exception exception);

Widget defaultEmptyBuilder(BuildContext context) => const EmptyInfo();

Widget defaultLoadingBuilder(BuildContext context) => const LoadingInfo();

Widget defaultExceptionBuilder(BuildContext context, Exception exception) =>
    ExceptionInfo(exception);
