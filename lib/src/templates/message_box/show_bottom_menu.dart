import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../components.dart';
import '../../../dimens.dart';
import '../safe_padding.dart';

@sealed
abstract class MenuItemEntry<T> {
  Widget get title;

  T get value;

  T get groupValue;
}

class MenuItem<T> implements MenuItemEntry<T> {
  const MenuItem({
    @required this.value,
    @required this.title,
    this.groupValue,
    this.icon,
    this.iconData,
  })  : assert(value != null),
        assert(title != null);

  @override
  final Widget title;
  @override
  final T value;
  @override
  final T groupValue;
  final IconData iconData;
  final Widget icon;
}

class CheckboxMenuItem<T> implements MenuItemEntry<T> {
  CheckboxMenuItem({this.title, this.value, this.groupValue});

  @override
  final Widget title;
  @override
  final T value;
  @override
  final T groupValue;
}

class TitleMenuItem<T> implements MenuItemEntry<T> {
  TitleMenuItem(String title) : _text = title;

  final String _text;

  @override
  Widget get title {
    return Center(
      child: Padding(
        padding: activityHorizontalMargin + itemSpacingVertical,
        child: Body1(_text),
      ),
    );
  }

  @override
  T get value => null;

  @override
  T get groupValue => null;
}

extension<T> on MenuItemEntry<T> {
  Widget leading(ThemeData theme) {
    final item = this;
    Widget child;
    if (item is MenuItem<T>) {
      child = item.icon ?? (item.iconData != null ? Icon(item.iconData) : null);
    } else if (item is CheckboxMenuItem<T>) {
      child = item.value == item.groupValue
          ? const Icon(CupertinoIcons.check_mark)
          : const SizedBox(width: 24, height: 24);
    } else {
      child = null;
    }
    if (child == null) {
      return null;
    }
    return IconTheme(
      data: IconThemeData(
        color: item.checked
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
      ),
      child: child,
    );
  }

  bool get checked => groupValue != null && groupValue == value;
}

Future<T> showBottomMenu<T>(
  BuildContext context, {
  String title,
  List<MenuItemEntry<T>> items,
  List<Widget> actions = const [],
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => BottomSheet(
      onClosing: () {},
      builder: (context) {
        final theme = Theme.of(context);
        final subtitle1 = theme.textTheme.subtitle1;
        final selectedSubtitle1 = subtitle1.copyWith(
          color: theme.colorScheme.primary,
        );
        return ListView(
          shrinkWrap: true,
          padding: safePaddingBottom(context),
          children: [
            if (title != null)
              Center(
                child: Padding(
                  padding: activityHorizontalMargin + itemSpacingVertical,
                  child: Body1(title),
                ),
              ),
            for (final item in items)
              if (item is TitleMenuItem)
                item.title
              else
                ListItem(
                  title: DefaultTextStyle(
                    style: item.checked ? selectedSubtitle1 : subtitle1,
                    child: item.title,
                  ),
                  leading: item.leading(theme),
                  onTap: () {
                    Navigator.of(context).pop(item.value);
                  },
                ),
            ...actions,
          ],
        );
      },
    ),
  );
}
