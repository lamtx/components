import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    Key key,
    this.body,
    this.appBar,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);

  final Widget body;
  final ObstructingPreferredSizeWidget appBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar,
        child: body,
      );
    } else {
      return Scaffold(
        body: body,
        appBar: appBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      );
    }
  }
}
