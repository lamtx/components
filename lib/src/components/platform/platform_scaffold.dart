import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc.dart';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  final Widget body;
  final ObstructingPreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: body,
      );
    } else {
      return Scaffold(
        body: body,
        appBar: appBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );
    }
  }
}
