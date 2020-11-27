import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformTabScaffold extends StatelessWidget {
  const PlatformTabScaffold({
    Key? key,
    required this.tabBuilder,
    required this.tabController,
    required this.tabs,
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
    Key? key,
    required this.tabController,
    required this.tabBuilder,
    this.appBar,
    required this.tabs,
  }) : super(key: key);
  final CupertinoTabController tabController;
  final IndexedWidgetBuilder tabBuilder;
  final PreferredSizeWidget? appBar;
  final List<BottomNavigationBarItem> tabs;

  @override
  _BottomNavigationScaffoldState createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<_BottomNavigationScaffold> {
  final _bucket = PageStorageBucket();
  var _cache = const <Widget?>[];

  @override
  Widget build(BuildContext context) {
    var child = _cache[widget.tabController.index];
    if (child == null) {
      child = widget.tabBuilder(context, widget.tabController.index);
      _cache[widget.tabController.index] = child;
    }
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.tabController.index,
        onTap: (index) => widget.tabController.index = index,
        items: widget.tabs,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_onTabChanged);
    _cache = List<Widget?>.filled(widget.tabs.length, null);
  }

  @override
  void didUpdateWidget(_BottomNavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.tabController.removeListener(_onTabChanged);
    widget.tabController.addListener(_onTabChanged);
    if (widget.tabs.length != oldWidget.tabs.length) {
      _cache = List<Widget?>.filled(widget.tabs.length, null);
    }
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
