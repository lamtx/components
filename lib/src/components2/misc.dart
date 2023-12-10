import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';

Widget decidePadding({
  required Widget child,
  EdgeInsets? padding,
}) =>
    Padding(
      padding: padding ?? spacingHorizontal,
      child: child,
    );

bool get isCupertino {
  if (debugDefaultTargetPlatformOverride != null) {
    return debugDefaultTargetPlatformOverride == TargetPlatform.iOS ||
        debugDefaultTargetPlatformOverride == TargetPlatform.macOS;
  }
  return Platform.isIOS || Platform.isMacOS;
}

///
/// Use FutureOr to allow the caller ignore the result
/// The return type is always Future<SnackBarClosedReason>
///
FutureOr<SnackBarClosedReason> showToast(
  BuildContext context,
  String message, [
  String? action,
]) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            action: action == null
                ? null
                : SnackBarAction(
                    label: action,
                    textColor: Theme.of(context).colorScheme.inversePrimary,
                    onPressed: () {},
                  ),
          ),
        )
        .closed;

extension ThemeExt on ThemeData {
  Color applySurfaceTint(double elevation) => ElevationOverlay.applySurfaceTint(
        colorScheme.surface,
        colorScheme.surfaceTint,
        elevation,
      );
}

EdgeInsets avoidFloatingActionButtonPadding(BuildContext context) =>
    EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 56);

// specs: https://m3.material.io/components/extended-fab/specs
// height 56, spacing 16
EdgeInsets avoidExtendedFloatingActionButtonPadding(BuildContext context) =>
    EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 56 + 16);
