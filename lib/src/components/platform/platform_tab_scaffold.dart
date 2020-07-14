import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformTabScaffold extends StatelessWidget {
  const PlatformTabScaffold({
    Key key,
    @required this.tabBuilder,
    @required this.tabController,
    @required this.tabs,
  }) : super(key: key);

  final CupertinoTabController tabController;
  final IndexedWidgetBuilder tabBuilder;
  final List<BottomNavigationBarItem> tabs;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: tabs,
        ),
        controller: tabController,
        tabBuilder: (context, index) => CupertinoTabView(
          builder: (context) => tabBuilder(context, index),
        ),
      );
    } else {
      return _BottomNavigationScaffold(
        tabController: tabController,
        tabBuilder: tabBuilder,
        tabs: tabs,
      );
    }
  }
}

class _BottomNavigationScaffold extends StatefulWidget {
  const _BottomNavigationScaffold({
    Key key,
    this.tabController,
    this.tabBuilder,
    this.appBar,
    this.tabs,
  }) : super(key: key);
  final CupertinoTabController tabController;
  final IndexedWidgetBuilder tabBuilder;
  final PreferredSizeWidget appBar;
  final List<BottomNavigationBarItem> tabs;

  @override
  _BottomNavigationScaffoldState createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<_BottomNavigationScaffold> {
  final _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageStorage(
            bucket: _bucket,
            child: widget.tabBuilder(context, widget.tabController.index),
          ),
        ),
        BottomNavigationBar(
          currentIndex: widget.tabController.index,
          onTap: (index) => widget.tabController.index = index,
          items: widget.tabs,
          type: BottomNavigationBarType.fixed,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_onTabChanged);
  }

  @override
  void didUpdateWidget(_BottomNavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.tabController.removeListener(_onTabChanged);
    widget.tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {});
  }
}
