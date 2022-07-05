import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'misc.dart';

// ignore_for_file: non_constant_identifier_names
Widget PlatformAlertDialog({
  Widget? title,
  Widget? content,
  List<Widget> actions = const <Widget>[],
  ShapeBorder? shape,
}) {
  if (isCupertino) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  } else {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      shape: shape,
    );
  }
}

Widget DialogButton({
  required Widget child,
  VoidCallback? onPressed,
  bool isDefaultAction = false,
  bool isDestructiveAction = false,
}) {
  if (isCupertino) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      child: child,
    );
  } else {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool? barrierDismissible,
}) {
  if (isCupertino) {
    return showCupertinoDialog(
      context: context,
      builder: builder,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible ?? false,
    );
  } else {
    return showDialog(
      context: context,
      builder: builder,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible ?? true,
    );
  }
}
