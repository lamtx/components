import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';

abstract class PlatformAppBar implements ObstructingPreferredSizeWidget {
  factory PlatformAppBar({
    Key? key,
    Widget? title,
    String? previousPageTitle,
    List<Widget>? actions,
    Color? backgroundColor,
    Brightness? brightness,
    Color? actionsForegroundColor,
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) {
    if (Platform.isIOS) {
      Widget? trailing;
      if (actions == null) {
        trailing = null;
      } else if (actions.length == 1) {
        trailing = actions.first;
      } else {
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        );
      }
      return _CupertinoNavigationBar(
        key: key,
        title: title,
        previousPageTitle: previousPageTitle,
        trailing: trailing,
        backgroundColor: backgroundColor,
        brightness: brightness,
        actionsForegroundColor: actionsForegroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: leading,
      );
    } else {
      return _AppBar(
        key: key,
        title: title,
        actions: actions,
        backgroundColor: backgroundColor,
        brightness: brightness,
        actionsForegroundColor: actionsForegroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: leading,
      );
    }
  }
}

class _CupertinoNavigationBar extends CupertinoNavigationBar
    implements PlatformAppBar {
  const _CupertinoNavigationBar({
    Key? key,
    Widget? title,
    String? previousPageTitle,
    Widget? trailing,
    Color? backgroundColor,
    Brightness? brightness,
    Color? actionsForegroundColor,
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) : super(
          key: key,
          middle: title,
          previousPageTitle: previousPageTitle,
          trailing: trailing,
          backgroundColor: backgroundColor,
          border: const Border(), // TODO: set it back to null
          brightness: brightness,
          actionsForegroundColor: actionsForegroundColor,
          automaticallyImplyMiddle: false,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
        );

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final backgroundColor =
        CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
            CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF || backgroundColor.alpha == 0;
  }
}

class _AppBar extends AppBar implements PlatformAppBar {
  _AppBar({
    Key? key,
    Widget? title,
    PreferredSizeWidget? bottom,
    List<Widget>? actions,
    Color? backgroundColor,
    Brightness? brightness,
    Color? actionsForegroundColor,
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) : super(
          key: key,
          title: title,
          bottom: bottom,
          actions: actions,
          backgroundColor: backgroundColor,
          brightness: brightness,
          actionsIconTheme: actionsForegroundColor == null
              ? null
              : IconThemeData(
                  color: actionsForegroundColor,
                ),
          iconTheme: actionsForegroundColor == null
              ? null
              : IconThemeData(
                  color: actionsForegroundColor,
                ),
          titleSpacing: activityHorizontalMargin.left,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
        );

  @override
  bool shouldFullyObstruct(BuildContext context) {
    throw UnsupportedError("shouldFullyObstruct should not be used in Android");
  }
}
