import 'package:flutter/material.dart';

class TabIndexedStack extends StatefulWidget {
  const TabIndexedStack({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _TabIndexedStackState createState() => _TabIndexedStackState();
}

class _TabIndexedStackState extends State<TabIndexedStack> {
  TabController? _controller;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: widget.children,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final newController = DefaultTabController.of(context);
    if (newController == _controller) {
      return;
    }
    if (_controllerIsValid) {
      _controller!.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _handleTabControllerTick() {
    _currentIndex = _controller!.index;
    setState(() {});
  }
}
