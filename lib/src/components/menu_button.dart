import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform/platform_icon_button.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key key, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      icon: Icon(Platform.isIOS ? CupertinoIcons.ellipsis : Icons.more_vert),
      onPressed: onPressed,
    );
  }
}
