import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components2.dart';
import '../templates/message_box.dart';

@optionalTypeArgs
class MenuButton<T> extends StatelessWidget {
  MenuButton({
    Key? key,
    this.onPressed,
    this.onItemSelected,
    this.items = const [],
  })  : assert(items.isEmpty || onItemSelected != null),
        assert((onPressed == null) != (onItemSelected == null)),
        super(key: key);

  final VoidCallback? onPressed;
  final List<MenuItemEntry<T>> items;
  final ValueChanged<T>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isCupertino ? CupertinoIcons.ellipsis : Icons.more_vert),
      onPressed: items.isEmpty ? onPressed : () => _showMenu(context),
    );
  }

  void _showMenu(BuildContext context) async {
    final item = await showPlatformMenu<T>(context, items: items);
    if (item != null) {
      onItemSelected!.call(item);
    }
  }
}
