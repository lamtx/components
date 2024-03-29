import 'package:flutter/material.dart';

import '../../components2.dart';
import '../../dimens.dart';

final class ListItemHeight {
  const ListItemHeight(this._height);

  final double _height;

  static const small = ListItemHeight(listPreferredItemHeightSmall);
  static const medium = ListItemHeight(listPreferredItemHeight);
  static const large = ListItemHeight(listPreferredItemHeightLarge);
}

@Deprecated("Use [ListTile]")
final class ListItem extends StatelessWidget {
  @Deprecated("Use [ListTile]")
  const ListItem({
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.contentPadding,
    this.itemHeight,
    this.onLongPress,
    super.key,
  });

  @Deprecated("Use [ListTile]")
  factory ListItem.dense({
    required Widget title,
    Widget? leading,
    VoidCallback? onTap,
  }) =>
      ListItem(
        title: title,
        leading: leading,
        onTap: onTap,
        contentPadding: halfItemSpacingVertical,
      );
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? contentPadding;
  final ListItemHeight? itemHeight;

  @override
  Widget build(BuildContext context) {
    final itemHeight = this.itemHeight ??
        (subtitle == null ? ListItemHeight.small : ListItemHeight.medium);
    final center = subtitle == null
        ? Align(
            alignment: Alignment.centerLeft,
            child: title,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              title,
              Padding(
                padding: textSpacingTop,
                child: subtitle,
              )
            ],
          );
    Widget child;
    if (trailing != null || leading != null) {
      child = Row(
        children: <Widget>[
          if (leading != null)
            Padding(
              padding: itemSpacingEnd,
              child: leading,
            ),
          Expanded(child: center),
          if (trailing != null) trailing!,
        ],
      );
    } else {
      child = center;
    }

    final container = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: itemHeight._height,
      ),
      child: contentPadding == null
          ? BreakpointPadding(
              padding: halfItemSpacingVertical,
              child: child,
            )
          : Padding(
              padding: contentPadding!,
              child: child,
            ),
    );
    if (onTap != null || onLongPress != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: container,
      );
    } else {
      return container;
    }
  }
}
