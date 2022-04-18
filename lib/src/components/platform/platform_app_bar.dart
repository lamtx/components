import 'package:ext/ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';
import '../misc.dart';

abstract class PlatformAppBar implements ObstructingPreferredSizeWidget {
  factory PlatformAppBar({
    Key? key,
    Widget? title,
    String? previousPageTitle,
    List<Widget> actions = const [],
    Color? backgroundColor,
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) {
    if (isCupertino) {
      Widget? trailing;
      if (actions.isEmpty) {
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
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: leading,
      );
    } else {
      return _AppBar(
        key: key,
        title: title,
        actions: actions.takeIf((element) => element.isNotEmpty),
        backgroundColor: backgroundColor,
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
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) : super(
          key: key,
          middle: title,
          previousPageTitle: previousPageTitle,
          trailing: trailing,
          backgroundColor: backgroundColor,
          border: null,
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
    bool automaticallyImplyLeading = true,
    Widget? leading,
  }) : super(
          key: key,
          title: title,
          bottom: bottom,
          actions: actions,
          backgroundColor: backgroundColor,
          // ignore: deprecated_member_use_from_same_package
          titleSpacing: activityHorizontalMargin.left,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
        );

  @override
  bool shouldFullyObstruct(BuildContext context) {
    throw UnsupportedError("shouldFullyObstruct should not be used in Android");
  }
}
