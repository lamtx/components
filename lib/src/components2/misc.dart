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
