import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';

class PlatformSliverAppBar extends StatelessWidget {
  const PlatformSliverAppBar({Key key, this.title, this.actions, this.bottom})
      : super(key: key);

  final Widget title;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;

  @override
  Widget build(BuildContext context) {
    List<Widget> actionButtons;
    final theme = Theme.of(context);
    if (actions == null || actions.isEmpty || Platform.isAndroid) {
      actionButtons = actions;
    } else {
      final primaryColor = theme.primaryColor;
      actionButtons = actions
          .map((e) => IconTheme(
                data: IconThemeData(
                  color: primaryColor,
                ),
                child: e,
              ))
          .toList();
    }
    return SliverAppBar(
      title: title,
      actions: actionButtons,
      floating: true,
      snap: true,
      pinned: true,
      titleSpacing: activityHorizontalMargin.left,
      bottom: bottom,
      elevation: 4,
    );
  }
}
