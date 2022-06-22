import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'breakpoint.dart';

Widget decidePadding({
  EdgeInsets? padding,
  required Widget child,
}) =>
    padding == null
        ? BreakpointPadding(child: child)
        : Padding(
            padding: padding,
            child: child,
          );

bool get isCupertino {
  if (debugDefaultTargetPlatformOverride != null) {
    return debugDefaultTargetPlatformOverride == TargetPlatform.iOS ||
        debugDefaultTargetPlatformOverride == TargetPlatform.macOS;
  }
  return Platform.isIOS || Platform.isMacOS;
}
